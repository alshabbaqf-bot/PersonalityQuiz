//
//  Quiz.swift
//  PersonalityQuiz
//
//  Created by Alshabbaq on 09/02/2026.
//

import Foundation

// MARK: - Result types per quiz

enum AnimalType: String, CaseIterable {
    case lion = "a 🦁", cat = "a 🐱", rabbit = "a 🐰", turtle = "a 🐢"

    var definition: String {
        switch self {
        case .lion:   return "You are outgoing and enjoy leading and being around others."
        case .cat:    return "Independent and curious, you like doing things on your own terms."
        case .rabbit: return "Energetic and optimistic, you enjoy new experiences."
        case .turtle: return "Calm and steady, you prefer a peaceful, planned approach."
        }
    }
}

enum ColorType: String, CaseIterable {
    case red = "🔴", blue = "🔵", green = "🟢", yellow = "🟡"

    var definition: String {
        switch self {
        case .red:    return "Bold, driven, and action-oriented."
        case .blue:   return "Calm, thoughtful, and reliable."
        case .green:  return "Balanced, supportive, and patient."
        case .yellow: return "Creative, cheerful, and spontaneous."
        }
    }
}

enum CareerType: String, CaseIterable {
    case leader = "a Leader👩‍💼"
    case engineer = "an Engineer👷"
    case designer = "a Designer🎨"
    case planner = "a Planner📝"

    var definition: String {
        switch self {
        case .leader:   return "You thrive in leadership, communication, and decision-making roles."
        case .engineer: return "You enjoy problem-solving, logic, and building systems."
        case .designer: return "You value creativity, aesthetics, and user experience."
        case .planner:  return "You excel at organization, structure, and long-term planning."
        }
    }
}

/// Single wrapper to allow different result enums in the same app model.
enum QuizResult {
    case animal(AnimalType)
    case color(ColorType)
    case career(CareerType)

    var emoji: String {
        switch self {
        case .animal(let a): return a.rawValue
        case .color(let c):  return c.rawValue
        case .career(let k): return k.rawValue
        }
    }

    var definition: String {
        switch self {
        case .animal(let a): return a.definition
        case .color(let c):  return c.definition
        case .career(let k): return k.definition
        }
    }
}

// MARK: - Quiz models

struct Quiz {
    let id: String
    let title: String
    let subtitle: String
    let icon: String
    let questions: [Question]
}

struct Question {
    let text: String
    let type: ResponseType
    let answers: [Answer]
}

enum ResponseType {
    case single, multiple, ranged
}

struct Answer {
    let text: String
    let result: QuizResult
}

// MARK: - Quiz bank

enum QuizBank {
    static let all: [Quiz] = [
        // 1) Animal Quiz -> AnimalType results
        Quiz(
            id: "animal",
            title: "Animal Personality",
            subtitle: "Discover which animal you are",
            icon: "🦁",
            questions: [
                Question(text: "Which food do you like the most?", type: .single, answers: [
                    Answer(text: "Steak",   result: .animal(.lion)),
                    Answer(text: "Fish",    result: .animal(.cat)),
                    Answer(text: "Carrots", result: .animal(.rabbit)),
                    Answer(text: "Corn",    result: .animal(.turtle))
                ]),
                Question(text: "Which activities do you enjoy?", type: .multiple, answers: [
                    Answer(text: "Swimming",  result: .animal(.turtle)),
                    Answer(text: "Sleeping",  result: .animal(.cat)),
                    Answer(text: "Cuddling",  result: .animal(.rabbit)),
                    Answer(text: "Eating",    result: .animal(.lion)),
                ]),
                Question(text: "How much do you enjoy car rides?", type: .ranged, answers: [
                    Answer(text: "I dislike them",        result: .animal(.cat)),
                    Answer(text: "I get a little nervous",result: .animal(.rabbit)),
                    Answer(text: "I barely notice them",  result: .animal(.turtle)),
                    Answer(text: "I love them",           result: .animal(.lion))
                ])
            ]
        ),

        // 2) Color Quiz -> ColorType results
        Quiz(
            id: "color",
            title: "Color Personality",
            subtitle: "Find your dominant color personality",
            icon: "🎨",
            questions: [
                Question(text: "Pick a weekend activity:", type: .single, answers: [
                    Answer(text: "Hiking",           result: .color(.green)),
                    Answer(text: "Gaming",           result: .color(.blue)),
                    Answer(text: "Party with friends",result: .color(.red)),
                    Answer(text: "Try something new", result: .color(.yellow))
                ]),
                Question(text: "What describes you?", type: .multiple, answers: [
                    Answer(text: "Calm",        result: .color(.blue)),
                    Answer(text: "Creative",    result: .color(.yellow)),
                    Answer(text: "Confident",   result: .color(.red)),
                    Answer(text: "Supportive",  result: .color(.green))
                ]),
                Question(text: "How do you handle pressure?", type: .ranged, answers: [
                    Answer(text: "I panic",         result: .color(.yellow)),
                    Answer(text: "I worry a bit",   result: .color(.blue)),
                    Answer(text: "I stay steady",   result: .color(.green)),
                    Answer(text: "I take control",  result: .color(.red))
                ])
            ]
        ),

        // 3) Career Quiz -> CareerType results
        Quiz(
            id: "career",
            title: "Career Personality",
            subtitle: "Discover which career path fits your personality",
            icon: "💼",
            questions: [
                Question(text: "Which task sounds most fun?", type: .single, answers: [
                    Answer(text: "Lead a team",        result: .career(.leader)),
                    Answer(text: "Solve a tricky bug", result: .career(.engineer)),
                    Answer(text: "Design a clean UI",  result: .career(.designer)),
                    Answer(text: "Plan and organize",  result: .career(.planner))
                ]),
                Question(text: "You prefer work that is:", type: .multiple, answers: [
                    Answer(text: "People-focused",  result: .career(.leader)),
                    Answer(text: "Detail-focused",  result: .career(.planner)),
                    Answer(text: "Creative",        result: .career(.designer)),
                    Answer(text: "Independent",     result: .career(.engineer))
                ]),
                Question(text: "How do you feel about deadlines?", type: .ranged, answers: [
                    Answer(text: "Very stressed",      result: .career(.designer)),
                    Answer(text: "Somewhat stressed",  result: .career(.engineer)),
                    Answer(text: "Okay",               result: .career(.planner)),
                    Answer(text: "Motivated",          result: .career(.leader))
                ])
            ]
        )
    ]
}

