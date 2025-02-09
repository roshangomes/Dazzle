//
//  TopLabelCollectionViewCell.swift
//  Dazzle
//
//  Created by Sunny on 16/11/24.
//

import UIKit

class TopLabelCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var topLabel: UILabel!
    
    
    @IBOutlet weak var topButton: UIButton!
    
    func setup(with top : TopLabel)
    {
        topLabel.text = top.title
        
    }

}

