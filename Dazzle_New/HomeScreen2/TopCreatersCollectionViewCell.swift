//
//  TopCollectionViewCell.swift
//  Dazzle
//
//  Created by Sunny on 16/11/24.
//

import UIKit
import SDWebImage

class TopCreatersCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var topImage: UIImageView!
    
    @IBOutlet weak var topDesign: UILabel!
    
    @IBOutlet weak var designCount: UILabel!
    
    
    func setup(with creator: Creator) {
            // Set Name
        topDesign.text = creator.name
            
            // Set Post Count
            designCount.text = "\(creator.postCount) Posts"
            
            // Round Profile Image
            topImage.layer.cornerRadius = topImage.frame.height / 2
            topImage.layer.masksToBounds = true
            
            // Load Image from URL (if it's a URL)
            if let url = URL(string: creator.profileImage) {
                topImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
            } else {
                topImage.image = UIImage(named: "placeholder") // Fallback
            }
        }
}
