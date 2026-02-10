//
//  ResultsViewController.swift
//  PersonalityQuiz
//
//  Created by Alshabbaq on 03/02/2026.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var quiz: Quiz
    var responses: [Answer]
    
    @IBOutlet weak var resultAnswerLabel: UILabel!
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    
    init?(coder: NSCoder, quiz: Quiz, responses: [Answer]) {
        self.quiz = quiz
        self.responses = responses
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatePersonalityResultAndSave()
        navigationItem.hidesBackButton = true
    }
    
    private func calculatePersonalityResultAndSave() {
        // Count QuizResult frequency
        var counts: [String: Int] = [:]
        var map: [String: QuizResult] = [:]

        for answer in responses {
            let r = answer.result
            let key = String(describing: r)
            counts[key, default: 0] += 1
            if map[key] == nil { map[key] = r }
        }

        guard let bestKey = counts.max(by: { $0.value < $1.value })?.key,
              let finalResult = map[bestKey] else {
            resultAnswerLabel.text = "No result"
            resultDefinitionLabel.text = ""
            return
        }

        // UI
        resultAnswerLabel.text = "You are \(finalResult.emoji)!"
        resultDefinitionLabel.text = finalResult.definition

        // SAVE to history
        let item = CompletedQuiz(
            quizId: quiz.id,
            quizTitle: quiz.title,
            resultEmoji: finalResult.emoji,
            resultDefinition: finalResult.definition,
            completedAt: Date()
        )
        HistoryStore.add(item)

        // TEST (temporary): print history in console
        print("History saved. Total items:", HistoryStore.load().count)
    }

}// class end
