//
//  CheckOutViewController.swift
//  Dazzle
//
//  Created by Sunny on 18/11/24.
//

import UIKit

class CheckOutViewController: UIViewController {
    
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var confirmLabel: UILabel!
    
    @IBOutlet weak var cancelButt: UIButton!
    
    @IBOutlet weak var subLabel: UILabel!
    
    @IBOutlet weak var subMoney: UILabel!
    
    @IBOutlet weak var shippingLabel: UILabel!
    
    
    @IBOutlet weak var shippingMoney: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    
    @IBOutlet weak var totalMoney: UILabel!
    
    @IBOutlet weak var deliveryButton: UIButton!
    
    @IBOutlet weak var orderButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func deliveryButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowAddressEntryScreen", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "ShowAddressEntryScreen" {
                // Pass any necessary data to the AddressViewController
            }
        }
    
    
    
}
