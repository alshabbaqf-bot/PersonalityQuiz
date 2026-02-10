//
//  QuizCell.swift
//  PersonalityQuiz
//
//  Created by Alshabbaq on 09/02/2026.
//

import Foundation
import UIKit

class QuizCell: UITableViewCell {
    
    

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        // Card appearance
        cardView.layer.cornerRadius = 18
        cardView.layer.masksToBounds = false

        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.08
        cardView.layer.shadowRadius = 10
        cardView.layer.shadowOffset = CGSize(width: 0, height: 1)
    }
}
