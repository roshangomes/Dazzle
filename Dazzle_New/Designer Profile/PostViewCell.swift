//
//  DesiGPostViewCell.swift
//  Dazzle_New
//
//  Created by Steve on 16/02/25.
//

import Foundation
import UIKit

class PostViewCell: UICollectionViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    
    override func awakeFromNib() {
            super.awakeFromNib()
            postImageView.contentMode = .scaleAspectFill
            postImageView.clipsToBounds = true
        }
}
