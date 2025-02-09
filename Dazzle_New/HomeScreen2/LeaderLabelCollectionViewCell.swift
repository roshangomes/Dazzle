//
//  LeaderLabelCollectionViewCell.swift
//  Dazzle
//
//  Created by Sunny on 16/11/24.
//

import UIKit

class LeaderLabelCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var LeaderLabel: UILabel!
    
    @IBOutlet weak var LeaderButton: UIButton!
    
    func setup(with leadB : LeaderBLabel)
    {
        LeaderLabel.text = leadB.title
    }

}

