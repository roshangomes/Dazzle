//
//  UIImageViewExtensions.swift
//  Dazzle_New
//
//  Created by Steve on 24/01/25.
//

import UIKit

extension UIImageView {
    func loadImagefromURL(from url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}
