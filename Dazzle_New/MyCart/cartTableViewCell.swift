//
//  cartTableViewCell.swift
//  Dazzle
//
//  Created by Sunny on 18/11/24.
//

import UIKit

class cartTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var CartImage: UIImageView!
    
    @IBOutlet weak var NameLabel: UILabel!
    
    @IBOutlet weak var colorLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var sizeLabel: UILabel!
    
    @IBOutlet weak var rankLabel: UILabel!
    
    
    @IBOutlet weak var moneyLabel: UILabel!
    
    @IBOutlet weak var quantButt: UIStepper!
    
    
    @IBOutlet weak var removeButton: UIButton!
    
    @IBOutlet weak var buyNowButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
