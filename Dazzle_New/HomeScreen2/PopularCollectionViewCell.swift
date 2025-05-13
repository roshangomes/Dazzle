//
//  PopularCollectionViewCell.swift
//  Dazzle
//
//  Created by Sunny on 16/11/24.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var popularView: UIView!
    
    @IBOutlet weak var popularImage: UIImageView!
    
    @IBOutlet weak var popularTitle: UILabel!
    
    @IBOutlet weak var popularName: UILabel!
    
    func configure(with post: CommunityPost) {
          popularTitle.text = post.postDescription  // ✅ Post description
          popularName.text = "@"+post.username  // ✅ Username
          
          if let imageUrl = post.postImages.first, let url = URL(string: imageUrl) {
              popularImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholderImage"))
          }
          
          // Styling
          popularView.layer.cornerRadius = 10
          popularView.layer.borderColor = UIColor.systemGray.cgColor
          popularView.layer.borderWidth = 1.0
          popularImage.layer.cornerRadius = 20
          popularImage.layer.masksToBounds = true
      }
  
}
