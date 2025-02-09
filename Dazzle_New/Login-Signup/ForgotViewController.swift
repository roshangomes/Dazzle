//
//  ForgotViewController.swift
//  Dazzle
//
//  Created by Steve on 19/11/24.
//

import UIKit
import FirebaseAuth

class ForgotViewController: UIViewController {
    
    @IBOutlet weak var displayImageView: UIImageView!
    
    @IBOutlet weak var forgotLabel: UILabel!
    
    
    @IBOutlet weak var text1Label: UILabel!
    
   
    @IBOutlet weak var PicArtImageView: UIImageView!
    
    @IBOutlet weak var enterEmailTextField: UITextField!
    
    
    @IBOutlet weak var SubmitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        guard let email = enterEmailTextField.text, !email.isEmpty else {
                    showAlert(message: "Please enter your email address.")
                    return
                }
                
                // Firebase Password Reset
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                self.showAlert(message: error.localizedDescription)
                return
            }
            
            // Password reset email sent
            self.showAlert(
                message: "A password reset email has been sent to \(email).",
                isSuccess: true,
                completion: {
                    // Navigate back to SignInViewController
                    self.dismiss(animated: true, completion: nil)
                }
            )
        }
    }
    
    func showAlert(message: String, isSuccess: Bool = false, completion: (() -> Void)? = nil) {
            let alert = UIAlertController(
                title: isSuccess ? "Success" : "Error",
                message: message,
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                completion?()
            }))
            
            present(alert, animated: true, completion: nil)
        }
    
    
}
