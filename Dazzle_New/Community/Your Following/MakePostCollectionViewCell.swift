//
//  MakePostCollectionViewCell.swift
//  Dazzle
//
//  Created by Steve on 17/11/24.
//

import UIKit

class MakePostCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var makePostLabel: UILabel!
    
    @IBOutlet weak var postButton: UIButton!
    
    
    func configure(with user: User) {
          profileImage.image = user.profileImageName
//          makePostLabel.text = user.makepostLabel
        
        let imageWidth = profileImage.frame.size.width
           let imageHeight = profileImage.frame.size.height
           
           // Ensure the image is square
           if imageWidth == 0 || imageHeight == 0 {
               return
           }

           // Make the profile image circular
           profileImage.layer.cornerRadius = min(imageWidth, imageHeight) / 2
           profileImage.clipsToBounds = true
      }
  }

