//
//  QuizResultCalculator.swift
//  PersonalityQuiz
//
//  Created by Alshabbaq on 15/02/2026.
//

import Foundation

import Foundation

enum QuizResultCalculator {

    static func calculate(from responses: [Answer]) -> QuizResult? {

        // Count QuizResult frequency
        var counts: [String: Int] = [:]
        var map: [String: QuizResult] = [:]

        for answer in responses {
            let result = answer.result
            let key = String(describing: result)

            counts[key, default: 0] += 1
            if map[key] == nil {
                map[key] = result
            }
        }

        guard let bestKey = counts.max(by: { $0.value < $1.value })?.key,
              let finalResult = map[bestKey] else {
            return nil
        }

        return finalResult
    }
}
