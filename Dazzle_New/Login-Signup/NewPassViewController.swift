//
//  NewPassViewController.swift
//  Dazzle
//
//  Created by Steve on 19/11/24.
//


import UIKit

class NewPassViewController: UIViewController {
    
    
    @IBOutlet weak var displayImageView: UIImageView!
    
    @IBOutlet weak var TitleLabel: UILabel!
    
    
    @IBOutlet weak var clipArt1ImageView: UIImageView!
    
    @IBOutlet weak var clipArt2ImageView: UIImageView!
   
   
    
    @IBOutlet weak var newpassText: UITextField!
    
    
    @IBOutlet weak var retypeText: UITextField!
    
    
    @IBOutlet weak var finishButt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func ButtTapped(_ sender: Any) {
        performSegue(withIdentifier: "backtosignin", sender: sender)
    }
}
