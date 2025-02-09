//
//  OTPViewController.swift
//  Dazzle
//
//  Created by Steve on 19/11/24.
//


import UIKit

class OTPViewController: UIViewController {
    
    
    @IBOutlet weak var otpLabel: UILabel!
    
    
    @IBOutlet weak var textLabel: UILabel!
    
    
    @IBOutlet weak var text1: UITextField!
    
    @IBOutlet weak var text2: UITextField!
    
    
    @IBOutlet weak var text3: UITextField!
    
    
    @IBOutlet weak var text4: UITextField!
    
    
    @IBOutlet weak var text5: UITextField!
    
    
    @IBOutlet weak var verifyButt: UIButton!
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func ButtonTapped(_ sender: Any) {
        
        performSegue(withIdentifier: "newpassword", sender: sender)
    }
    
}
