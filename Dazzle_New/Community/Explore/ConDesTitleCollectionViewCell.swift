//
//  ConDesTitleCollectionViewCell.swift
//  Dazzle
//
//  Created by Steve on 19/11/24.
//

import UIKit

class ConDesTitleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var contactDesignerLabel: UILabel!
    
    override func awakeFromNib() {
           super.awakeFromNib()
           // Set the label's title
           contactDesignerLabel.text = "Contact Designer"
       }
}
