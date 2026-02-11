//
//  CompletedQuiz.swift
//  PersonalityQuiz
//
//  Created by Alshabbaq on 10/02/2026.
//

import Foundation

struct CompletedQuiz: Codable {
    let quizId: String
    let quizTitle: String
    let resultEmoji: String
    let resultDefinition: String
    let completedAt: Date
}
