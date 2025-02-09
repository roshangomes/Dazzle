//
//  PostsCollectionViewCell.swift
//  Dazzle
//
//  Created by Sunny on 19/11/24.
//

import UIKit

class PostsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    
    @IBOutlet weak var sharedaPost: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    @IBOutlet weak var desclabel: UILabel!
    
    @IBOutlet weak var hashLabels: UILabel!
    
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var heartButt: UIButton!
    
    @IBOutlet weak var msgButt: UIButton!
    
    
    @IBOutlet weak var shareButt: UIButton!
    
    
    
    func setup(with post : Post){
        profileImage.image = post.profileImage
        sharedaPost.text = post.name
        timeLabel.text = post.time
        desclabel.text = post.desc
        
        postImage.image = post.postImage
        profileImage.layer.cornerRadius = profileImage.frame.height/2
    }
    
}




