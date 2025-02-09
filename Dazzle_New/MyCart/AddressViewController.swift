//
//  AddressViewController.swift
//  Dazzle
//
//  Created by Sunny on 19/11/24.
//

import UIKit

class AddressViewController: UIViewController {
    
    
    @IBOutlet weak var backButton: UIButton!
    
    
    @IBOutlet weak var countryTextField: UITextField!
    
    
    @IBOutlet weak var stateTextField: UITextField!
    
    
    @IBOutlet weak var addressTextField: UITextField!
    
    
    @IBOutlet weak var houseTextField: UITextField!
    
    
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    
    @IBOutlet weak var cityTextField: UITextField!
    
    
    @IBOutlet weak var addAddressButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addAddressButtonTapped(_ sender: UIButton) {
        
        // Validate and save the entered address
                let address = [
                    addressTextField.text,
                    cityTextField.text,
                    cityTextField.text,
                    stateTextField.text,
                    zipCodeTextField.text,
                    countryTextField.text
                ]

                if address.contains(where: { $0?.isEmpty ?? true }) {
                    // Show an alert if any field is empty
                    let alert = UIAlertController(title: "Incomplete Details", message: "Please fill all the fields.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                } else {
                    // Save address or pass it to the previous screen
                    print("Address Saved: \(address)")
                    self.dismiss(animated: true, completion: nil)
                }
            }
    }
