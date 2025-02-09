//
//  ContactDesignerCollectionViewCell.swift
//  Dazzle
//
//  Created by Steve on 18/11/24.
//

import UIKit

class ContactDesignerCollectionViewCell: UICollectionViewCell {
    
   
    
    @IBOutlet weak var designerImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var contactButton: UIButton!
    
    // Configure function to set up the cell
       func configure(with designer: Designer) {
           // Set the designer's name
           usernameLabel.text = designer.name
           
           // Set the designer's image
           designerImageView.image = UIImage(named: designer.profileImageName)
           
           // Style the profile image as circular
           designerImageView.layer.cornerRadius = designerImageView.frame.height / 2
           designerImageView.clipsToBounds = true
           
           // Set the title label (if applicable)
          
           
           // Configure the contact button
           contactButton.setTitle("Contact", for: .normal)
           contactButton.isEnabled = designer.isContactable
           contactButton.alpha = designer.isContactable ? 1.0 : 0.5 // Dim button if not contactable
           contactButton.layer.cornerRadius = 10
           
       }
}

