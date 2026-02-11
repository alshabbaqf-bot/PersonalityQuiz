//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by Alshabbaq on 03/02/2026.
//

import UIKit

class QuestionViewController: UIViewController {
    
    // MARK: - Model / Data
    
    var quiz: Quiz!
    private var questions: [Question] = []
    var questionIndex = 0
    var answersChosen: [Answer] = []
    private var displayedAnswers: [Answer] = []
    private var multipleSwitches: [(control: UISwitch, answer: Answer)] = []
    
    private var timer: Timer?
    private let timePerQuestion = 10
    private var secondsLeft = 0
    
    // MARK: - Outlets
    
    @IBOutlet weak var questionLable: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var answersStackView: UIStackView!

    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedLable1: UILabel!
    @IBOutlet weak var rangedLable2: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!

    @IBOutlet weak var questionProgressView: UIProgressView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questions = quiz.questions
        questions.shuffle() // randomize question order
        updateUI()
    }
    
    // MARK: - UI Update
    
    func updateUI() {
        // Hide both areas first
        answersStackView.isHidden = true
        rangedStackView.isHidden = true

        // Reset dynamic UI
        clearAnswersStack()
        multipleSwitches = []
        
        let currentQuestion = questions[questionIndex]
        
        // Prepare answers (shuffle only for single + multiple)
        var currentAnswers = currentQuestion.answers
        if currentQuestion.type == .single || currentQuestion.type == .multiple {
            currentAnswers.shuffle()
        }
        displayedAnswers = currentAnswers
        
        // Progress + title
        let totalProgress = Float(questionIndex) / Float(questions.count)
        navigationItem.title = "Question #\(questionIndex + 1)"
        questionLable.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        // Build UI depending on type
        switch currentQuestion.type {
        case .single:
            answersStackView.isHidden = false
            buildSingleUI(answers: displayedAnswers)
        case .multiple:
            answersStackView.isHidden = false
            buildMultipleUI(answers: displayedAnswers)
        case .ranged:
            rangedStackView.isHidden = false
            updateRangedStack(using: displayedAnswers)
        }
        
        startTimer()
    }// end of updateUI
    
    private func clearAnswersStack() {
        for view in answersStackView.arrangedSubviews {
            answersStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
    
    func updateRangedStack(using answers: [Answer]) {
        rangedSlider.setValue(0.5, animated: false)

        rangedLable1.text = answers.first?.text
        rangedLable2.text = answers.last?.text
    }
    
    private func updateTimerLabel() {
        timerLabel.text = "Time: \(secondsLeft)s"
    }
    
    // MARK: - Timer
    private func startTimer() {
        stopTimer()
        secondsLeft = timePerQuestion
        updateTimerLabel()

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self else { return }
            self.secondsLeft -= 1
            self.updateTimerLabel()

            if self.secondsLeft <= 0 {
                self.stopTimer()
                self.handleTimeout()
            }
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    private func handleTimeout() {
        let currentQuestion = questions[questionIndex]

        switch currentQuestion.type {
        case .single:
            // No selection recorded
            break

        case .multiple:
            for item in multipleSwitches {
                if item.control.isOn {
                    answersChosen.append(item.answer)
                }
            }

        case .ranged:
            let index = Int(round(rangedSlider.value * Float(displayedAnswers.count - 1)))
            answersChosen.append(displayedAnswers[index])
        }

        nextQuestion()
    }
    
    deinit {
        stopTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopTimer()
    }

    // MARK: - Build Dynamic UI
    
    private func buildSingleUI(answers: [Answer]) {
        for (index, answer) in answers.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(answer.text, for: .normal)
            button.tag = index
            button.titleLabel?.numberOfLines = 0
            button.contentHorizontalAlignment = .center
            button.addTarget(self, action: #selector(singleTapped(_:)), for: .touchUpInside)

            answersStackView.addArrangedSubview(button)
        }
    }
    
    private func buildMultipleUI(answers: [Answer]) {
        for answer in answers {
            let row = UIStackView()
            row.axis = .horizontal
            row.alignment = .center
            row.spacing = 12

            let label = UILabel()
            label.text = answer.text
            label.numberOfLines = 0

            let toggle = UISwitch()

            row.addArrangedSubview(label)
            row.addArrangedSubview(toggle)

            answersStackView.addArrangedSubview(row)

            multipleSwitches.append((control: toggle, answer: answer))
        }

        let submit = UIButton(type: .system)
        submit.setTitle("Submit Answer", for: .normal)
        submit.addTarget(self, action: #selector(multipleSubmitTapped), for: .touchUpInside)
        answersStackView.addArrangedSubview(submit)
    }
    
    // MARK: - Navigation
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "Results", sender: nil)
        }
    }
    
    @IBSegueAction func showResults(_ coder: NSCoder) -> ResultsViewController? {
        return ResultsViewController(coder: coder, quiz: quiz, responses: answersChosen)
    }
    
    // MARK: - Actions
    
    @objc private func singleTapped(_ sender: UIButton) {
        stopTimer()
        let answer = displayedAnswers[sender.tag]
        answersChosen.append(answer)
        nextQuestion()
    }

    @objc private func multipleSubmitTapped() {
        stopTimer()
        for item in multipleSwitches {
            if item.control.isOn {
                answersChosen.append(item.answer)
            }
        }
        nextQuestion()
    }
    
    @IBAction func rangedSubmitPressed(_ sender: UIButton) {
        stopTimer()
        let index = Int(round(rangedSlider.value * Float(displayedAnswers.count - 1)))
        answersChosen.append(displayedAnswers[index])
        nextQuestion()
    }
} // class end
