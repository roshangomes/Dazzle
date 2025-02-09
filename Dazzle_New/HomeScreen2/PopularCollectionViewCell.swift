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
    
    func setup(with popular : Popular){
        popularTitle.text = popular.title
        popularName.text = popular.name
        popularImage.image = popular.image
        
        popularView.layer.cornerRadius = 10
        popularView.layer.masksToBounds = false
//        popularView.layer.shadowColor = UIColor.black.cgColor
//        popularView.layer.shadowOpacity = 0.2
//        popularView.layer.shadowOffset = CGSize(width: 0, height: 2)
//        popularView.layer.shadowRadius = 4
        popularView.layer.borderColor = UIColor.systemGray.cgColor
        popularImage.layer.borderWidth = 1.0
    
        
        popularImage.layer.cornerRadius = 20
        popularImage.layer.masksToBounds = true
        
        
    }
    
}
