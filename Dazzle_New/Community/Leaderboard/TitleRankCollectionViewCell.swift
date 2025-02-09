//
//  TitleRankCollectionViewCell.swift
//  Dazzle
//
//  Created by Steve on 18/11/24.
//

import UIKit

class TitleRankCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var TitleView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Corner radius
        TitleView.layer.cornerRadius = 10
        TitleView.layer.masksToBounds = false

        // Shadow
        TitleView.layer.shadowColor = UIColor.black.cgColor
        TitleView.layer.shadowOpacity = 0.2
        TitleView.layer.shadowOffset = CGSize(width: 0, height: 2)
        TitleView.layer.shadowRadius = 4
    }

}
