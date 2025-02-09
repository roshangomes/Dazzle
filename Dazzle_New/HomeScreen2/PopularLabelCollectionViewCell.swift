//
//  PopularLabelCollectionViewCell.swift
//  Dazzle
//
//  Created by Sunny on 16/11/24.
//

import UIKit

class PopularLabelCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var popularLabel: UILabel!
    
    @IBOutlet weak var popularButton: UIButton!
    
    func setup(with pop : PopLabel)
    {
        popularLabel.text = pop.title
    }
    
}
