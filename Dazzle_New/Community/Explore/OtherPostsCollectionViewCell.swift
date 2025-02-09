//
//  OtherPostsCollectionViewCell.swift
//  Dazzle
//
//  Created by Steve on 18/11/24.
//

import UIKit

class OtherPostsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var timeagoLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var likesLabel: UILabel!
    
//    func configure(with post: CommunityPost) {
//            // Set username
//            usernameLabel.text = post.username
//            
//            // Set time ago
//            timeagoLabel.text = post.timeAgo
//            
//            // Set post description
//            descriptionLabel.text = post.postDescription
//            
//            // Set user's profile image
//            if let profileImage = post.profileImageUrl {
//                userImageView.image = profileImage
//            } else {
//                userImageView.image = UIImage(named: "defaultProfileImage") // Default profile image
//            }
//            
//            // Make the profile image rounded
//            userImageView.layer.cornerRadius = userImageView.frame.height / 2
//            userImageView.layer.masksToBounds = true
//            
//            // Ensure layout is updated before setting corner radius
//            userImageView.layoutIfNeeded()
//
//            // Set post image
//            if let postImage = post.postImage {
//                postImageView.image = postImage
//            } else {
//                postImageView.isHidden = true // Hide if there's no image
//            }
//            
//            // Set likes label
//            likesLabel.text = "\(post.likeCount)"
//            
//            // Add shadow or rounded corners for UI polish
//            self.contentView.layer.cornerRadius = 10
//            self.contentView.layer.masksToBounds = true
//            self.contentView.layer.shadowColor = UIColor.black.cgColor
//            self.contentView.layer.shadowOpacity = 0.1
//            self.contentView.layer.shadowOffset = CGSize(width: 2, height: 2)
//            self.contentView.layer.shadowRadius = 4
//        }
}
