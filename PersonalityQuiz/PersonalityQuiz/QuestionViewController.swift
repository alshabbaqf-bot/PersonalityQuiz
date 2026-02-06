//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by Alshabbaq on 03/02/2026.
//

import UIKit

class QuestionViewController: UIViewController {
    
    var questions: [Question] = [
        Question(
            text: "Which food do you like the most?",
            type: .single,
            answers: [
                Answer(text: "Steak", type: .lion),
                Answer(text: "Fish", type: .cat),
                Answer(text: "Carrots", type: .rabbit),
                Answer(text: "Corn", type: .turtle)
            ]
        ),
        
        Question(
            text: "Which activities do you enjoy?",
            type: .multiple,
            answers: [
                Answer(text: "Swimming", type: .turtle),
                Answer(text: "Sleeping", type: .cat),
                Answer(text: "Cuddling", type: .rabbit),
                Answer(text: "Eating", type: .lion),
            ]
        ),
                
        Question(
            text: "How much do you enjoy car rides?" ,
            type: .ranged,
            answers: [
            Answer (text: "I dislike them", type: .cat) ,
            Answer (text: "I get a litle nervous", type: .rabbit),
            Answer(text: "I barely notice them", type: .turtle) ,
            Answer (text: "I love them", type: .lion)
            ]
        )
    ] // end of questions array
    
    @IBOutlet weak var questionLable: UILabel!

    @IBOutlet weak var answersStackView: UIStackView!

    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedLable1: UILabel!
    @IBOutlet weak var rangedLable2: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!

    @IBOutlet weak var questionProgressView: UIProgressView!
        
    var questionIndex = 0
    var answersChosen: [Answer] = []
    private var displayedAnswers: [Answer] = []
    private var multipleSwitches: [(control: UISwitch, answer: Answer)] = []
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questions.shuffle() // randomize question order
        updateUI()
    }
    
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
    }// end of updateUI
    
    private func clearAnswersStack() {
        for view in answersStackView.arrangedSubviews {
            answersStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "Results", sender: nil)
        }
    }
    
    func updateRangedStack(using answers: [Answer]) {
//        rangedSlider.minimumValue = 0
//        rangedSlider.maximumValue = Float(max(answers.count - 1, 0))
//        rangedSlider.setValue(rangedSlider.maximumValue / 2, animated: false)
        rangedSlider.setValue(0.5, animated: false)

        rangedLable1.text = answers.first?.text
        rangedLable2.text = answers.last?.text
    }
    
    @IBSegueAction func showResults(_ coder: NSCoder) -> ResultsViewController? {
        return ResultsViewController(coder: coder, responses: answersChosen)
    }
    
    @objc private func singleTapped(_ sender: UIButton) {
        let answer = displayedAnswers[sender.tag]
        answersChosen.append(answer)
        nextQuestion()
    }

    @objc private func multipleSubmitTapped() {
        for item in multipleSwitches {
            if item.control.isOn {
                answersChosen.append(item.answer)
            }
        }
        nextQuestion()
    }
    
    @IBAction func rangedSubmitPressed(_ sender: UIButton) {
        let index = Int(round(rangedSlider.value * Float(displayedAnswers.count - 1)))
        answersChosen.append(displayedAnswers[index])
        nextQuestion()
    }


} // class end
