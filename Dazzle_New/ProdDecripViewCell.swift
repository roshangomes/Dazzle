//
//  ProdDecripViewCell.swift
//  Dazzle_New
//
//  Created by Steve on 18/01/25.
//

import Foundation
import UIKit
class ProdDecripViewCell: UICollectionViewCell {
    
    
    // MARK: - Product Name and Description
    @IBOutlet weak var productnameLabel: UILabel!
    
    @IBOutlet weak var productDescriptionLabel: UILabel!
    
    
    // MARK: - Price and Size Details
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var sizeLabel: UILabel!
    
    @IBOutlet weak var smallButton: UIButton!
    
    @IBOutlet weak var mediumLabel: UIButton!
    @IBOutlet weak var largeLabel: UIButton!
    @IBOutlet weak var xlargeLabel: UIButton!
    
    // MARK: - Delivery Details
    @IBOutlet weak var deliverytoLabel: UILabel!
    @IBOutlet weak var deliveryAddressLabel: UILabel!
    @IBOutlet weak var addresschangeLabel: UIButton!
    @IBOutlet weak var deliverywithinLabel: UILabel!
    
    
    // MARK: - Product Specifications
    @IBOutlet weak var productdetailsLabel: UILabel!
    @IBOutlet weak var packofLabel: UILabel!
    @IBOutlet weak var frabricLabel: UILabel!
    @IBOutlet weak var sleeveLabel: UILabel!
    @IBOutlet weak var patternLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    
    @IBOutlet weak var noofpackNOLabel: UILabel!
    @IBOutlet weak var fabrictypeLabel: UILabel!
    @IBOutlet weak var sleevetypeLabel: UILabel!
    @IBOutlet weak var patterntypeLabel: UILabel!
    @IBOutlet weak var colortypeLabel: UILabel!
    
//    func configureCell(with product: Product) {
//            productNameLabel.text = product.name
//            productDescriptionLabel.text = product.description
//            priceLabel.text = "$\(product.price)"
//            
//            // Size buttons
//            smallButton.isSelected = product.selectedSize == "S"
//            mediumButton.isSelected = product.selectedSize == "M"
//            largeButton.isSelected = product.selectedSize == "L"
//            xlargeButton.isSelected = product.selectedSize == "XL"
//            
//            // Delivery details
//            deliveryToLabel.text = "Delivery to:"
//            deliveryAddressLabel.text = product.deliveryAddress
//            deliveryWithinLabel.text = "Delivered within \(product.deliveryTime) days"
//            
//            // Product specifications
//            noOfPackLabel.text = "\(product.packOf)"
//            fabricTypeLabel.text = product.fabric
//            sleeveTypeLabel.text = product.sleeve
//            patternTypeLabel.text = product.pattern
//            colorTypeLabel.text = product.color
//        }
    
}
