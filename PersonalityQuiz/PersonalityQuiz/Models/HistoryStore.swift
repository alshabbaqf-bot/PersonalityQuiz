//
//  HistoryStore.swift
//  PersonalityQuiz
//
//  Created by Alshabbaq on 10/02/2026.
//

import Foundation

enum HistoryStore {
    private static let key = "completed_quizzes_v1"

    static func load() -> [CompletedQuiz] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        return (try? JSONDecoder().decode([CompletedQuiz].self, from: data)) ?? []
    }

    static func save(_ items: [CompletedQuiz]) {
        if let data = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    static func add(_ item: CompletedQuiz) {
        var items = load()
        items.insert(item, at: 0)      // newest first
        save(items)
    }

    static func clear() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
