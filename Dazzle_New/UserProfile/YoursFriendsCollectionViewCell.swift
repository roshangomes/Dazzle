//
//  YoursFriendsCollectionViewCell.swift
//  Dazzle
//
//  Created by Sunny on 18/11/24.
//

import UIKit

class YoursFriendsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var YourFriends: UILabel!
    @IBOutlet weak var editButt: UIButton!
    
    func setup(with your : Your ){
        YourFriends.text = your.title
    }
}


