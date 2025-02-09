//
//  PostTitleCollectionViewCell.swift
//  Dazzle
//
//  Created by Steve on 19/11/24.
//

import UIKit

class PostTitleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var postTitleLabel: UILabel!
    
    override func awakeFromNib() {
           super.awakeFromNib()
           // Set the label's title
           postTitleLabel.text = "Posts"
       }
}
