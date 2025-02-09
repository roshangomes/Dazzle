//
//  LeaderBoardCollectionViewCell.swift
//  Dazzle
//
//  Created by Sunny on 16/11/24.
//

import UIKit

class LeaderBoardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var LeaderBoardView: UIView!
    
    
    @IBOutlet weak var LeaderBoardImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var heartButton: UIButton!
    
    func setup(with leader : Leader ){
        nameLabel.text = leader.title
        descLabel.text = leader.desc
        countLabel.text = leader.likes
        LeaderBoardImage.image = leader.image
        
        LeaderBoardView.layer.cornerRadius = 10
        LeaderBoardView.layer.masksToBounds = false
        
        LeaderBoardImage.layer.cornerRadius = 20
        LeaderBoardImage.layer.masksToBounds = true
    }
    
}
