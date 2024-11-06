//
//  SignUpButton.swift
//  Dazzle
//
//  Created by Steve on 03/11/24.
//

import UIKit

class SignUpButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        layer.backgroundColor = UIColor.systemBlue.cgColor
    }

}
