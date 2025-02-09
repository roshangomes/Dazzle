//
//  LeaderBoardCollectionViewCell.swift
//  Dazzle
//
//  Created by Steve on 17/11/24.
//

import UIKit

class LeaderBoard2CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var firstLabel: UILabel!
    
    @IBOutlet weak var firstImageView: UIImageView!
    
    @IBOutlet weak var firstuserLabel: UILabel!
    
    @IBOutlet weak var firstLikesLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var secondImageView: UIImageView!
    
    @IBOutlet weak var seconduserLabel: UILabel!
    
    @IBOutlet weak var secondLikesLabel: UILabel!
    
    @IBOutlet weak var thirdLabel: UILabel!
    
    @IBOutlet weak var thirdImageView: UIImageView!
    
    @IBOutlet weak var thirduserLabel: UILabel!
    
    @IBOutlet weak var thirdLikesLabel: UILabel!
    
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var firstView: UIView!
    
    @IBOutlet weak var thirdView: UIView!
    
    
    func configure(with leaderboardEntry: LeaderboardEntry) {
        // Configure the first user
        firstLabel.text = "#1"
        firstImageView.image = leaderboardEntry.firstUser.image
        firstuserLabel.text = leaderboardEntry.firstUser.name
        firstLikesLabel.text = "\(leaderboardEntry.firstUser.likes) likes"
        makeImageCircular(imageView: firstImageView)

        // Configure the second user
        secondLabel.text = "2."
        secondImageView.image = leaderboardEntry.secondUser.image
        seconduserLabel.text = leaderboardEntry.secondUser.name
        secondLikesLabel.text = "\(leaderboardEntry.secondUser.likes) likes"
        makeImageCircular(imageView: secondImageView)

        // Configure the third user
        thirdLabel.text = "3."
        thirdImageView.image = leaderboardEntry.thirdUser.image
        thirduserLabel.text = leaderboardEntry.thirdUser.name
        thirdLikesLabel.text = "\(leaderboardEntry.thirdUser.likes) likes"
        makeImageCircular(imageView: thirdImageView)

        // Style the views
        styleView(view: firstView)
        styleView(view: secondView)
        styleView(view: thirdView)
    }

        
        // Helper to style views
        private func styleView(view: UIView) {
            view.layer.cornerRadius = 10
            view.layer.masksToBounds = true
            view.layer.borderWidth = 0.5
            view.layer.borderColor = UIColor.lightGray.cgColor
        }
        
        // Helper to make images circular
        private func makeImageCircular(imageView: UIImageView) {
            imageView.layer.cornerRadius = imageView.frame.width / 2
            imageView.clipsToBounds = true
        }
    }
