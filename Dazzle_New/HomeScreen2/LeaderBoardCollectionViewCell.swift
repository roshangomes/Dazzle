//
//  LeaderBoardCollectionViewCell.swift
//  Dazzle
//
//  Created by Sunny on 16/11/24.
//

import UIKit

class LeaderBoardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var LeaderBoardView: UIView!
    
    
    @IBOutlet weak var LeaderBoardImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var heartButton: UIButton!
    
    func setup(with post: Post) {
            nameLabel.text = post.desc // Title (placeholder for now)
            
            countLabel.text = "\(post.likes)"  // Convert likes to string
            
            // Load image asynchronously
            if let url = URL(string: post.imageUrl) {
                LeaderBoardImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
            }
            
            // UI Customization
            LeaderBoardView.layer.cornerRadius = 10
            LeaderBoardView.layer.masksToBounds = false
            
            LeaderBoardImage.layer.cornerRadius = 20
            LeaderBoardImage.layer.masksToBounds = true
        }
}
