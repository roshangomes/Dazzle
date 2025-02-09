//
//  DesignCollectionViewcellCollectionViewCell.swift
//  Dazzle
//
//  Created by Steve on 03/11/24.
//

import UIKit

class PopularDesignCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var designImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var creatorLabel: UILabel!
    
    func configureCell(with design: TShirtDesign) {
            designImageView.image = UIImage(named: design.imageName)
            titleLabel.text = design.title
            creatorLabel.text = "@\(design.creatorUsername)"
            //priceLabel.text = "₹ \(design.price)"
        }
    
    
}
