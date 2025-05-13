//
//  LeaderBoardCollectionViewCell.swift
//  Dazzle
//
//  Created by Steve on 17/11/24.
//

import UIKit
import SDWebImage

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
    
    
    func configure(with leaderboardEntries: [LeaderboardUser]) {
        
        
        guard leaderboardEntries.count >= 3 else { return } // Ensure we have at least 3 users
        
        // **1st User**
        firstuserLabel.text = leaderboardEntries[0].name
        firstLikesLabel.text = "\(leaderboardEntries[0].likes) Likes"
        if let url = URL(string: leaderboardEntries[0].image) {
            firstImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "defaultProfileImage"))
        }
        
        // **2nd User**
        seconduserLabel.text = leaderboardEntries[1].name
        secondLikesLabel.text = "\(leaderboardEntries[1].likes) Likes"
        if let url = URL(string: leaderboardEntries[1].image) {
            secondImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "defaultProfileImage"))
        }
        
        // **3rd User**
        thirduserLabel.text = leaderboardEntries[2].name
        thirdLikesLabel.text = "\(leaderboardEntries[2].likes) Likes"
        if let url = URL(string: leaderboardEntries[2].image) {
            thirdImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "defaultProfileImage"))
        }
        
        // Make images circular
        makeImageCircular(imageView: firstImageView)
        makeImageCircular(imageView: secondImageView)
        makeImageCircular(imageView: thirdImageView)
    }
    private func makeImageCircular(imageView: UIImageView) {
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
    }

    
}
