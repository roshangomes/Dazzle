//
//  StaticCollectionViewCell.swift
//  Dazzle
//
//  Created by Sunny on 16/11/24.
//

import UIKit

class StaticCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var StaticImage: UIImageView!
    
    func setup(with stats : Static){
        StaticImage.image = stats.image
        
    }

}

