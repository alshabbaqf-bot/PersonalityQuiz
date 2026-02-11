//
//  ViewController.swift
//  PersonalityQuiz
//
//  Created by Alshabbaq on 02/02/2026.
//

import UIKit

class IntroductionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let quizzes = QuizBank.all
        private var selectedQuiz: Quiz?

        override func viewDidLoad() {
            super.viewDidLoad()

            tableView.dataSource = self
            tableView.delegate = self

            tableView.separatorStyle = .none
            tableView.backgroundColor = .clear
        }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "StartQuiz",
//           let dest = segue.destination as? QuestionViewController,
//           let quiz = selectedQuiz {
//            dest.quiz = quiz
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "StartQuiz",
              let quiz = selectedQuiz else { return }

        if let dest = segue.destination as? QuestionViewController {
            dest.quiz = quiz
        } else if let nav = segue.destination as? UINavigationController,
                  let dest = nav.topViewController as? QuestionViewController {
            dest.quiz = quiz
        }
    }
    
    @IBAction func unwindToQuizIntroduction (segue:
    UIStoryboardSegue) {
    }
}

extension IntroductionViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        quizzes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell", for: indexPath) as! QuizCell
        let quiz = quizzes[indexPath.row]

        cell.selectionStyle = .none
        cell.backgroundColor = .clear

        cell.iconLabel.text = quiz.icon
        cell.titleLabel.text = quiz.title
        cell.subtitleLabel.text = quiz.subtitle

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedQuiz = quizzes[indexPath.row]
        performSegue(withIdentifier: "StartQuiz", sender: nil)
    }
}

