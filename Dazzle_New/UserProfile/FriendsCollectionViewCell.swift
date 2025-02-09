//
//  FriendsCollectionViewCell.swift
//  Dazzle
//
//  Created by Sunny on 18/11/24.
//

import UIKit

class FriendsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var designLabel: UILabel!
    
    func setup(with friend : Friend) {
        userImage.image = friend.image
        nameLabel.text = friend.name
        designLabel.text = friend.designs
        
        userImage.layer.cornerRadius = userImage.frame.height / 2
        userImage.layer.masksToBounds = true
    }
    
}
