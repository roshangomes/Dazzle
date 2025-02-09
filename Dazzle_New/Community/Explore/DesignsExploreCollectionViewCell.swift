//
//  DesignsExploreCollectionViewCell.swift
//  Dazzle
//
//  Created by Steve on 18/11/24.
//

import UIKit

class DesignsExploreCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var designImageView: UIImageView!
    
    @IBOutlet weak var designTitle: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    @IBOutlet weak var priceLabel: UILabel!
    
    
    @IBOutlet weak var designView: UIView!
    
    func configure(with design: TShirtDesign) {
            // Set the design image
            designImageView.image = UIImage(named: design.imageName) // Load the image from assets or set an image loading method if the URL is used
            
            // Set the design title
            designTitle.text = design.title
            
            // Set the username
            usernameLabel.text = design.creatorUsername
            
            // Set the price
            priceLabel.text = "₹\(design.price)"
            
            // Style the design view (optional for rounded corners or shadows)
            designView.layer.cornerRadius = 10
            designView.layer.masksToBounds = true
            designView.layer.shadowColor = UIColor.black.cgColor
        designView.layer.shadowOffset = .zero
        designView.layer.shadowRadius = 10
        designView.layer.shadowOpacity = 0.5
        designView.layer.borderColor = UIColor.gray.cgColor
        designView.layer.borderWidth = 0.2
        
        }

}
