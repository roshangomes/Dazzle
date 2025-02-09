//
//  ConPeopTitleCollectionViewCell.swift
//  Dazzle
//
//  Created by Steve on 19/11/24.
//

import UIKit

class ConPeopTitleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var contactpeepTitleLabel: UILabel!
    
    override func awakeFromNib() {
           super.awakeFromNib()
           // Set the label's title
        contactpeepTitleLabel.text = "Connect People"
       }
}
