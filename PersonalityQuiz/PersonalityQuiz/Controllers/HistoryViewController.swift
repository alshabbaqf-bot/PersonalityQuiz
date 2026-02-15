//
//  HistoryViewController.swift
//  PersonalityQuiz
//
//  Created by Alshabbaq on 10/02/2026.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var history: [CompletedQuiz] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
                target: self,
                action: #selector(close)
            )

        history = HistoryStore.load()

        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        history = HistoryStore.load()
        tableView.reloadData()
    }
    
    @objc private func close() {
        dismiss(animated: true)
    }
}

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        history.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

//        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
//        let item = history[indexPath.row]
//
////        cell.textLabel?.text = "\(item.quizTitle)"
//        quizTitle.text = "\(item.quizTitle)"
//
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        formatter.timeStyle = .short
//
////        cell.detailTextLabel?.text = "You are \(item.resultEmoji)"
//        quizResult.text = "You are \(item.resultEmoji)"
//
//        return cell
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
                as? HistoryCell else {
                    return UITableViewCell()
                }

        let item = history[indexPath.row]

        cell.quizTitleLabel.text = item.quizTitle
        cell.quizResultLabel.text = "You are \(item.resultEmoji)"

        return cell
    }
    
}// class end
