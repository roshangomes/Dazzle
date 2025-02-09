//
//  DesignsCollectionViewCell.swift
//  Dazzle
//
//  Created by Sunny on 18/11/24.
//

import UIKit

class DesignsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var designImageView: UIImageView!
    
    @IBOutlet weak var designLabel: UILabel!
    
    @IBOutlet weak var AddButton: UIButton!
    
    func setup(with design : Design){
        designImageView.image = design.imageName
        designLabel.text = design.title
    }
    
}


