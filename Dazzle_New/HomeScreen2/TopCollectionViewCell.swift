//
//  TopCollectionViewCell.swift
//  Dazzle
//
//  Created by Sunny on 16/11/24.
//

import UIKit

class TopCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var topImage: UIImageView!
    
    @IBOutlet weak var topDesign: UILabel!
    
    @IBOutlet weak var designCount: UILabel!
    
    func setup(with creator : Creator) {
        topDesign.text = creator.title
        designCount.text = creator.design
        topImage.image = creator.image
        
        topImage.layer.cornerRadius = topImage.frame.height / 2
        topImage.layer.masksToBounds = true
        
    }
}
