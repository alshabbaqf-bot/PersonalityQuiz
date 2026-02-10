//
//  ResultsViewController.swift
//  PersonalityQuiz
//
//  Created by Alshabbaq on 03/02/2026.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var responses: [Answer]
    
    @IBOutlet weak var resultAnswerLabel: UILabel!
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    
    init?(coder: NSCoder, responses: [Answer]) {
        self.responses = responses
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatePersonalityResult()
        navigationItem.hidesBackButton = true
    }
    
//    func calculatePersonalityResult()
//    {
//        let frequencyOfAnswers = responses.reduce(into: [AnimalType: Int]()) {
//            (counts, answer) in
//            if let existingCount = counts[answer.type] {
//                counts[answer.type] = existingCount + 1
//            } else {
//                counts[answer.type] = 1
//            }
//        }
//                    
//        let mostCommonAnswer = frequencyOfAnswers.sorted { $0.1 > $1.1}.first!.key
//        
//       resultAnswerLabel.text = "You are a \(mostCommonAnswer.rawValue)!"
//        resultDefinitionLabel.text = mostCommonAnswer.definition
//        
//    }
    
    private func calculatePersonalityResult() {
            // Count results
            var counts: [String: Int] = [:]
            var map: [String: QuizResult] = [:]

            for answer in responses {
                let r = answer.result
                let key = String(describing: r)      // unique key per case
                counts[key, default: 0] += 1
                if map[key] == nil { map[key] = r }
            }

            guard let bestKey = counts.max(by: { $0.value < $1.value })?.key,
                  let finalResult = map[bestKey] else {
                resultAnswerLabel.text = "No result"
                resultDefinitionLabel.text = ""
                return
            }

            resultAnswerLabel.text = "You are \(finalResult.emoji)!"
            resultDefinitionLabel.text = finalResult.definition
        }
    
}// class end
