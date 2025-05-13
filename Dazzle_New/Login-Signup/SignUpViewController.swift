//
//  LoginViewController.swift
//  Dazzle
//
//  Created by Steve on 19/11/24.


import UIKit
import AuthenticationServices
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class SignUpViewController: UIViewController {

   

    @IBOutlet weak var SignupLabel: UILabel!
    
    
    @IBOutlet weak var clip1ImageView: UIImageView!
    
    @IBOutlet weak var UserText: UITextField!
    
    
    @IBOutlet weak var clip2ImageView: UIImageView!
    
    @IBOutlet weak var EmailText: UITextField!
    
    @IBOutlet weak var clip3ImageView: UIImageView!
    
    @IBOutlet weak var PasswordText: UITextField!
    
    
    
    @IBOutlet weak var designerLabel: UILabel!
    
    
    @IBOutlet weak var designerSwitch: UISwitch!
    
    @IBOutlet weak var SignUpButton: UIButton!
    
    
    @IBOutlet weak var InstantLabel: UILabel!
    
    
    @IBOutlet weak var alertLabel: UILabel!
    
    
    @IBOutlet weak var SignInButton: UIButton!
    
    
    let db = Firestore.firestore() // Firestore reference
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertLabel.isHidden = true
        
        PasswordText.isSecureTextEntry = true
        designerSwitch.isOn = false // ✅ Ensure toggle is OFF by default
        
        // Add the eye button to the password field
            let eyeButton = UIButton(type: .custom)
            eyeButton.setImage(UIImage(systemName: "eye"), for: .normal) // Default eye icon
            eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .selected) // Eye slash icon for hidden state
            eyeButton.tintColor = .gray
            eyeButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            eyeButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)

            PasswordText.rightView = eyeButton
            PasswordText.rightViewMode = .always
        
    }
    
    
    @objc func togglePasswordVisibility(_ sender: UIButton) {
        sender.isSelected.toggle() // Toggle the button's selected state
        PasswordText.isSecureTextEntry.toggle() // Toggle the secure text entry
    }

    
    
   
    @IBAction func SignUpTapped(_ sender: UIButton) {
        // Ensure all fields are filled
        guard let username = UserText.text, !username.isEmpty else {
            showAlert(message: "Please enter your username")
            return
        }
        
        guard let email = EmailText.text, !email.isEmpty else {
            showAlert(message: "Please enter your email")
            return
        }
        
        guard let password = PasswordText.text, !password.isEmpty else {
            showAlert(message: "Please enter your password")
            return
        }
        
        // Validate email format
        if !isValidEmail(email) {
            showAlert(message: "Please enter a valid email address")
            return
        }
        
        // Validate password length
        if password.count < 6 {
            showAlert(message: "Password must be at least 6 characters long")
            return
        }
        
        let isDesigner = designerSwitch.isOn
            let userType = isDesigner ? "designer" : "user"  // ✅ Determine userType
            
        
        
        // Show loading indicator
        let loadingAlert = UIAlertController(title: nil, message: "Signing up...\n\n", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(style: .large)

        // Customize the loading indicator
        loadingIndicator.color = .systemBlue
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false

        // Add the loading indicator to the alert view
        loadingAlert.view.addSubview(loadingIndicator)

        // Add constraints for centering the loading indicator
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: loadingAlert.view.centerXAnchor),
            loadingIndicator.topAnchor.constraint(equalTo: loadingAlert.view.topAnchor, constant: 60)
        ])

        // Start animating the indicator
        loadingIndicator.startAnimating()

        // Present the alert
        present(loadingAlert, animated: true, completion: nil)

        // Create the user in Firebase Authentication
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.dismiss(animated: true) {
                    self.showAlert(message: error.localizedDescription)
                }
                return
            }
            
            guard let userId = authResult?.user.uid else {
                self.dismiss(animated: true) {
                    self.showAlert(message: "User ID not found.")
                }
                return
            }
            
            // Assign the default profile picture
            self.assignDefaultProfilePicture(userId: userId) { profileImageUrl in
                // Save user data to Firestore
                self.saveUserDataToFirestore(uid: userId, username: username, email: email, profileImageUrl: profileImageUrl, userType: userType)
                
                // Dismiss loading alert and show success message
                self.dismiss(animated: true) {
                    self.showAlert(message: "Signup Successful!", isSuccess: true)
                }}}}
           

    
    func assignDefaultProfilePicture(userId: String, completion: @escaping (String) -> Void) {
        // Default image name
        let defaultImageName = "default1"

        // Retrieve the image from assets
        guard let image = UIImage(named: defaultImageName) else {
            print("Default image not found in assets.")
            completion("") // Return empty on failure
            return
        }

        // Convert the image to data
        guard let imageData = image.pngData() else { // Use `.pngData()` for PNG
            print("Failed to convert default image to data.")
            completion("") // Return empty on failure
            return
        }

        // Define the file path in Firebase Storage
        let storageRef = Storage.storage().reference().child("profileImages/\(userId).png") // Ensure .png extension

        // Upload the image
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Error uploading profile image: \(error.localizedDescription)")
                completion("") // Return empty on failure
                return
            }

            // Retrieve the download URL
            storageRef.downloadURL { url, error in
                if let error = error {
                    print("Error getting profile image URL: \(error.localizedDescription)")
                    completion("") // Return empty on failure
                    return
                }

                guard let profileImageUrl = url?.absoluteString else {
                    print("Download URL is nil.")
                    completion("") // Return empty if URL is nil
                    return
                }

                print("Profile image uploaded successfully. URL: \(profileImageUrl)")
                completion(profileImageUrl) // Return the URL
            }
        }
    }



    
                   

           func isValidEmail(_ email: String) -> Bool {
               let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
               return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
           }

    func showAlert(message: String, isSuccess: Bool = false) {
        alertLabel.text = message
        alertLabel.textColor = isSuccess ? .systemGreen : .systemRed
        alertLabel.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.alertLabel.isHidden = true
        }
    }

    
    //MARK: SAVE USER DATAT TO FIRESTORE
    func saveUserDataToFirestore(uid: String, username: String, email: String, profileImageUrl: String,userType: String) {
        // Generate custom userId
        let usernamePart = String(username.prefix(4)).lowercased() // First 4 letters of the username
        let uidPart = String(uid.suffix(4)) // Last 4 letters of the Firebase UID
        let userId = usernamePart + uidPart // Combine to create custom userId
        
        // Define the Firestore user data dictionary
        let userData: [String: Any] = [
            "uid": uid, // Firebase UID
            "userId": userId, // Custom User ID
            "username": username,
            "email": email,
            "profileImageUrl": profileImageUrl,
            "userType": userType,   // Store user type in Firestore
            "createdAt": FieldValue.serverTimestamp()
        ]
        
        // Firestore user document reference
        let userDoc = db.collection("users").document(uid)
        
        // Save data to Firestore
        userDoc.setData(userData) { error in
            if let error = error {
                self.showAlert(message: "Failed to save user data: \(error.localizedDescription)")
            } else {
                // Display success pop-up
                let alertController = UIAlertController(
                    title: "Signup Successful!",
                    message: "You have successfully signed up. Click the button below to go to the Sign-In page.",
                    preferredStyle: .alert
                )
                
                let signInAction = UIAlertAction(title: "Go to Sign-In", style: .default) { _ in
                    if let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController {
                        loginVC.modalPresentationStyle = .fullScreen
                        self.present(loginVC, animated: true, completion: nil)
                    }
                }
                
                alertController.addAction(signInAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    

    

    @IBAction func SignInTapped(_ sender: Any) {
        if let loginVC = storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController {
                    loginVC.modalPresentationStyle = .fullScreen
                    self.present(loginVC, animated: true, completion: nil)
                }
    }
}

    
    
        
    



    

