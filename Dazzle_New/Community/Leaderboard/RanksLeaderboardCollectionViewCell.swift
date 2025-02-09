//
//  RanksLeaderboardCollectionViewCell.swift
//  Dazzle
//
//  Created by Steve on 18/11/24.
//

import UIKit

class RanksLeaderboardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var rankLabel: UILabel!
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var likesLabel: UILabel!
    
    func configure(with leaderboardEntry: Leaderboard) {
        // Populate rank
        rankLabel.text = "\(leaderboardEntry.rank)"
        
        // Populate profile image
        userImage.image = leaderboardEntry.profileImage
        userImage.contentMode = .scaleAspectFill
        userImage.layer.cornerRadius = userImage.frame.size.width / 2
        userImage.clipsToBounds = true
        
        // Populate username
        usernameLabel.text = leaderboardEntry.username
        
        // Populate likes
        likesLabel.text = "\(leaderboardEntry.likes)"
    }

}
