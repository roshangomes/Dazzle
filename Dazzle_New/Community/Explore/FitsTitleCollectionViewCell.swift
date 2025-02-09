//
//  FitsTitleCollectionViewCell.swift
//  Dazzle
//
//  Created by Steve on 19/11/24.
//

import UIKit

class FitsTitleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var designerfitsTitle: UILabel!
    
    override func awakeFromNib() {
           super.awakeFromNib()
           // Set the label's title
        designerfitsTitle.text = "Designer Fits"
       }
}
