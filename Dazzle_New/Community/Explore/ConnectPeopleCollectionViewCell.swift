//
//  ConnectPeopleCollectionViewCell.swift
//  Dazzle
//
//  Created by Steve on 18/11/24.
//

import UIKit

class ConnectPeopleCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var peopleImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var connectButton: UIButton!
    
    func configure(with person: ConnectPeople) {
            // Set static and dynamic data
             // Static title
            usernameLabel.text = person.name
            peopleImageView.image = UIImage(named: person.profileImageName) // Load image from assets
            
            // Round the image
        peopleImageView.layer.cornerRadius = 40
            peopleImageView.clipsToBounds = true
            
            // Button setup
            connectButton.setTitle("Connect", for: .normal)
            connectButton.isEnabled = true // Always enabled
            connectButton.layer.cornerRadius = 10 // Optional: Add rounded corners for the button
        
        }
}
