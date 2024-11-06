//
//  CommunityTableViewCell.swift
//  Dazzle
//
//  Created by Steve on 06/11/24.
//

import UIKit

class CommunityPostTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var timesnapLabel: UILabel!
    
    @IBOutlet weak var postbioLabel: UILabel!
    
    @IBOutlet weak var postImageView: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Optional: Styling for profile image view (making it circular)
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.clipsToBounds = true
    }
    
    // Configure the cell with data from the model
    func configure(with post: CommunityPost) {
        userNameLabel.text = (post.user) 
        timesnapLabel.text = post.timeAgo
        postbioLabel.text = post.textContent
        profileImageView.image = UIImage(named: post.user.profileImageName)
        postImageView.image = UIImage(named: post.images)
        
        
        
    }
}
