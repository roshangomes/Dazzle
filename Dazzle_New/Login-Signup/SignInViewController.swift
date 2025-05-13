//
//  SignInViewController.swift
//  Dazzle
//
//  Created by Steve on 19/11/24.
//


import UIKit
import LocalAuthentication
import FirebaseAuth
import AuthenticationServices
import Firebase

class SignInViewController: UIViewController {
    @IBOutlet weak var displayImageView: UIImageView!
    
    @IBOutlet weak var TitleLabel: UILabel!
    
    
    @IBOutlet weak var alertLabel: UILabel!
   
   
    @IBOutlet weak var clipArt1ImageView: UIImageView!
    
    @IBOutlet weak var clipArt2ImageView: UIImageView!
    
    @IBOutlet weak var UsernameText: UITextField!
    
    @IBOutlet weak var PasswordText: UITextField!
    
    
    @IBOutlet weak var ForgotButton: UIButton!
    
    @IBOutlet weak var LoginInButton: UIButton!
    
    
    @IBOutlet weak var DontLabel: UILabel!
    
    
    @IBOutlet weak var SignUpButton: UIButton!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    
    @IBOutlet weak var signInWithGoogleTapped: UIButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        alertLabel.isHidden = true // Initially hide the alert label
        
        PasswordText.isSecureTextEntry = true
        
        // Add the eye button to the password field
            let eyeButton = UIButton(type: .custom)
            eyeButton.setImage(UIImage(systemName: "eye"), for: .normal) // Default eye icon
            eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .selected) // Eye slash icon for hidden state
            eyeButton.tintColor = .gray
            eyeButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            eyeButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)

            PasswordText.rightView = eyeButton
            PasswordText.rightViewMode = .always
        
        // Set up Apple Sign-In Button programmatically
              let appleButton = ASAuthorizationAppleIDButton()
              appleButton.translatesAutoresizingMaskIntoConstraints = false
              appleButton.addTarget(self, action: #selector(signInWithAppleTapped), for: .touchUpInside)
        
        // Make the Apple Sign-In button round by setting corner radius
        appleButton.layer.cornerRadius = 22.5 // Adjust to make it as round as you want
            appleButton.layer.masksToBounds = true  // Ensure the contents are clipped to the rounded corners

            


              // Add to the placeholder UIView
              if let placeholderView = self.view.viewWithTag(101) { // Ensure this UIView exists in storyboard with tag 101
                  placeholderView.addSubview(appleButton)
                  NSLayoutConstraint.activate([
                      appleButton.leadingAnchor.constraint(equalTo: placeholderView.leadingAnchor),
                      appleButton.trailingAnchor.constraint(equalTo: placeholderView.trailingAnchor),
                      appleButton.topAnchor.constraint(equalTo: placeholderView.topAnchor),
                      appleButton.bottomAnchor.constraint(equalTo: placeholderView.bottomAnchor)
                  ])
              }
        
    }
    
    
    @objc func togglePasswordVisibility(_ sender: UIButton) {
        sender.isSelected.toggle() // Toggle the button's selected state
        PasswordText.isSecureTextEntry.toggle() // Toggle the secure text entry
    }

    
    @IBAction func ForgotTapped(_ sender: Any) {
        
        
    }
    
    
    @IBAction func LogInTapped(_ sender: Any) {
        
        guard let email = UsernameText.text, !email.isEmpty else {
                    showAlert(message: "Please enter your email.")
                    return
                }
                
                guard let password = PasswordText.text, !password.isEmpty else {
                    showAlert(message: "Please enter your password.")
                    return
                }
                
        // Show the loading indicator
            loadingIndicator.startAnimating()
            
        
                // Firebase Authentication for Sign-In
                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                    
                    // Hide the loading indicator when Firebase call completes
                            self.loadingIndicator.stopAnimating()
                            
                    
                    if let error = error as NSError? {
                        // Use AuthErrorCode to get the error type
                        if let errorCode = AuthErrorCode(rawValue: error.code) {
                            switch errorCode {
                            case .invalidEmail:
                                self.showAlert(message: "Invalid email format. Please enter a valid email.")
                            case .wrongPassword:
                                self.showAlert(message: "Incorrect password. Please try again.")
                            case .userNotFound:
                                self.showAlert(message: "No account found for this email. Please sign up.")
                            case .userDisabled:
                                self.showAlert(message: "Your account has been disabled. Contact support.")
                            default:
                                self.showAlert(message: "An error occurred: \(error.localizedDescription)")
                            }
                        } else {
                            self.showAlert(message: "An unknown error occurred.")
                        }
                        return
                    }


                    
                    // Login successful
                    self.showAlert(message: "Login successful! Welcome back, \(email).", isSuccess: true)
                    
                    // Navigate to the main/home page
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        // Example: Navigate to HomeViewController
                        if let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "TabController") {
                            homeVC.modalPresentationStyle = .fullScreen
                            self.present(homeVC, animated: true, completion: nil)
                        }
                    }
                }
    }

    
    @IBAction func SignUpTapped(_ sender: UIButton) {
        
        if let signUpVC = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
                    signUpVC.modalPresentationStyle = .fullScreen
                    self.present(signUpVC, animated: true, completion: nil)
                }
        
    }
    
    func showAlert(message: String, isSuccess: Bool = false) {
            alertLabel.text = message
            alertLabel.textColor = isSuccess ? .systemGreen : .systemRed
            alertLabel.isHidden = false
        }
    

    @IBAction func signInWithGoogleTapped(_ sender: UIButton) {
        // Perform Google Sign-In
    }


    @objc func signInWithAppleTapped() {
        // Add Apple Sign-In logic
    }
    
}
