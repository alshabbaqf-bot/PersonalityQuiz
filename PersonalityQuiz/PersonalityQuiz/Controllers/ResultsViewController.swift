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
        
        // Count QuizResult
        guard let finalResult = QuizResultCalculator.calculate(from: responses) else {
                resultAnswerLabel.text = "No result"
                resultDefinitionLabel.text = ""
                return
            }

        // UI update
        resultAnswerLabel.text = "You are \(finalResult.emoji)!"
        resultDefinitionLabel.text = finalResult.definition

        // Save to history
        let item = CompletedQuiz(
            quizId: quiz.id,
            quizTitle: quiz.title,
            resultEmoji: finalResult.emoji,
            resultDefinition: finalResult.definition,
            completedAt: Date()
        )
        
        HistoryStore.add(item)
    }

}// class end
