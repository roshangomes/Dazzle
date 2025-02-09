//
//  ProfileCollectionViewCell.swift
//  Dazzle
//
//  Created by Sunny on 18/11/24.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var editButton: UIButton!
    
    
    @IBOutlet weak var DetailsLabel: UILabel!
    
    @IBOutlet weak var userId: UILabel!
    
    @IBOutlet weak var UsernameLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var linkLabel: UILabel!
    
    var onEditButtonTapped: (() -> Void)? // Closure for handling button tap
        
        func setup(with profileCell: ProfileCell) {
            UsernameLabel.text = "Username: \(profileCell.username)"
                    userId.text = "User ID: @\(profileCell.userId)"
            locationLabel.text = "Location: \(profileCell.location ?? "Not set")"
            linkLabel.text = "Link: \(profileCell.link ?? "Not set")"

                


            // Add action for edit button
                    editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        }

    
    
    
        @IBAction func editButtonTapped(_ sender: UIButton) {
            print("Edit button tapped") 
            onEditButtonTapped?() // Trigger the closure
        }
    
}


