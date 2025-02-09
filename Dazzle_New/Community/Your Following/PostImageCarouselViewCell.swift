//
//  PostImageCarousel.swift
//  Dazzle_New
//
//  Created by Steve on 08/02/25.
//

import Foundation
import UIKit

class PostImageCarousel: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    func configure(with imageUrl: String) {
            if let url = URL(string: imageUrl) {
                imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "defaultPostImage"))
            }
        }
}
