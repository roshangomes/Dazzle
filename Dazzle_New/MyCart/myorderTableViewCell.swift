//
//  myorderTableViewCell.swift
//  Dazzle
//
//  Created by Sunny on 18/11/24.
//

import UIKit

class myorderTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var myImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var moneyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureStatusAppearance(status: String) {
        switch status {
        case "On The Way":
            statusLabel.textColor = UIColor.blue
            statusLabel.text = "On The Way" 
        case "Delivered":
            statusLabel.textColor = UIColor.green
            statusLabel.text = "✅ Delivered"
        case "Canceled":
            statusLabel.textColor = UIColor.red
            statusLabel.text = "❌ Cancelled"
        default:
            statusLabel.textColor = UIColor.black
            statusLabel.text = status
        }
    }
}
