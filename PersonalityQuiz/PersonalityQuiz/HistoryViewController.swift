//
//  HistoryViewController.swift
//  PersonalityQuiz
//
//  Created by Alshabbaq on 10/02/2026.
//

import Foundation
import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var history: [CompletedQuiz] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        history = HistoryStore.load()

        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        history = HistoryStore.load()
        tableView.reloadData()
    }
}

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        history.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
        let item = history[indexPath.row]

        cell.textLabel?.text = "\(item.resultEmoji)  \(item.quizTitle)"

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short

        cell.detailTextLabel?.text = formatter.string(from: item.completedAt)

        return cell
    }
}
