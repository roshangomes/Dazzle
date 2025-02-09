//
//  EditProfileViewController.swift
//  Dazzle
//
//  Created by Sunny on 19/11/24.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

protocol EditProfileDelegate: AnyObject {
    func didUpdateProfile(with updatedProfile: ProfileCell)
}


class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var profileData: ProfileCell?
    
    @IBOutlet weak var profileImageView: UIImageView!
    
//    
//    @IBOutlet weak var updatePictureLabel: UILabel!
//    
    
    @IBOutlet weak var uploadButton: UIButton!
    
    
    @IBOutlet weak var deleteButton: UIButton!
    
    
    @IBOutlet weak var nameField: UITextField!
    
    
    @IBOutlet weak var emailField: UITextField!
    
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var linkField: UITextField!
    
    @IBOutlet weak var updateButton: UIButton!
    
    // Declare an array to hold ProfileCell data
    var profileCells = [ProfileCell]() // Array to hold profile data
    
    var currentProfile: ProfileCell? // Reference to the original profile (optional)
    
    //MARK: - DELEGATE FOR UPDATE
    weak var delegate: EditProfileDelegate?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Current profile: \(currentProfile?.username ?? "No username")")
        setupUI()
    }
    
   
    private func setupUI() {
        // Apply placeholder style for existing profile data
        setPlaceholderStyle(for: nameField, withText: currentProfile?.username ?? "Enter name")
        setPlaceholderStyle(for: emailField, withText: currentProfile?.email ?? "Enter email")
        setPlaceholderStyle(for: locationTextField, withText: currentProfile?.location ?? "Not set")
        setPlaceholderStyle(for: linkField, withText: currentProfile?.link ?? "Not set")

        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.layer.masksToBounds = true

        // Load profile image if available
        if let profileImageUrl = currentProfile?.profileImageUrl, !profileImageUrl.isEmpty {
            if let url = URL(string: profileImageUrl) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                            self.profileImageView.image = UIImage(data: data)
                        }
                    }
                }
            }
        } else {
            profileImageView.image = UIImage(named: "defaultProfile")
        }
        
        addEditingListeners()
    }

    // MARK: - Placeholder Effect
    func setPlaceholderStyle(for textField: UITextField, withText text: String) {
        textField.attributedText = NSAttributedString(
            string: text,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
    }

    func addEditingListeners() {
        [nameField, emailField, locationTextField, linkField].forEach { textField in
            textField?.addTarget(self, action: #selector(textFieldEditingDidBegin(_:)), for: .editingDidBegin)
            textField?.addTarget(self, action: #selector(textFieldEditingDidEnd(_:)), for: .editingDidEnd)
        }
    }

    @objc func textFieldEditingDidBegin(_ textField: UITextField) {
        if textField.textColor == UIColor.gray {
            textField.text = ""
            textField.textColor = UIColor.black
        }
    }

    @objc func textFieldEditingDidEnd(_ textField: UITextField) {
        if textField.text?.isEmpty ?? true {
            setPlaceholderStyle(for: textField, withText: "Enter \(textField.placeholder ?? "text")")
        }
    }
    
    func uploadProfileImage(_ image: UIImage, completion: @escaping (String?) -> Void) {
        let storageRef = Storage.storage().reference()
        let profileImageRef = storageRef.child("profile_images/\(UUID().uuidString).jpg")
        
        if let imageData = image.jpegData(compressionQuality: 0.5) {
            profileImageRef.putData(imageData, metadata: nil) { metadata, error in
                if let error = error {
                    print("Error uploading image: \(error.localizedDescription)")
                    completion(nil)
                } else {
                    profileImageRef.downloadURL { url, error in
                        if let error = error {
                            print("Error getting download URL: \(error.localizedDescription)")
                            completion(nil)
                        } else if let url = url {
                            completion(url.absoluteString)
                        }
                    }
                }
            }
        }
    }

    
    @IBAction func uploadButtonTapped(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary
                present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        profileImageView.image = nil // Remove the image
    }
    
    
    
    
    //MARK: - UPDATE BUTTON TAPPED
    @IBAction func updateButtonTapped(_ sender: UIButton) {
        print("Update button tapped.")
            guard let userID = Auth.auth().currentUser?.uid else {
                print("User is not logged in")
                return
            }

            // Show loading alert
            print("Showing loading alert.")
            let loadingAlert = UIAlertController(title: nil, message: "Updating...\n\n", preferredStyle: .alert)
            let loadingIndicator = UIActivityIndicatorView(style: .large)
            loadingIndicator.color = .systemBlue
            loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
            loadingAlert.view.addSubview(loadingIndicator)

            NSLayoutConstraint.activate([
                loadingIndicator.centerXAnchor.constraint(equalTo: loadingAlert.view.centerXAnchor),
                loadingIndicator.topAnchor.constraint(equalTo: loadingAlert.view.topAnchor, constant: 60)
            ])

            loadingIndicator.startAnimating()
            present(loadingAlert, animated: true, completion: nil)

            // Firestore update
            let db = Firestore.firestore()
            let userRef = db.collection("users").document(userID)

            var updatedData: [String: Any] = [
                "username": nameField.text ?? currentProfile?.username ?? "",
                "email": emailField.text ?? currentProfile?.email ?? "",
                "location": locationTextField.text ?? currentProfile?.location ?? "Not set",
                "link": linkField.text ?? currentProfile?.link ?? "Not set"
            ]

            if let image = profileImageView.image, image != UIImage(named: "defaultProfile") {
                print("Uploading new profile image.")
                uploadProfileImage(image) { imageUrl in
                    if let imageUrl = imageUrl {
                        updatedData["profileImageUrl"] = imageUrl
                    }
                    userRef.updateData(updatedData) { error in
                        self.handleProfileUpdateCompletion(error: error, imageUrl: imageUrl, loadingAlert: loadingAlert)
                    }
                }
            } else {
                userRef.updateData(updatedData) { error in
                    self.handleProfileUpdateCompletion(error: error, imageUrl: self.currentProfile?.profileImageUrl, loadingAlert: loadingAlert)
                }
            }
        }
    
    
    // MARK:  HANDLING UPDATE COMPLETION
    func handleProfileUpdateCompletion(error: Error?, imageUrl: String?, loadingAlert: UIAlertController) {
        // Dismiss the loading alert once the update is complete
        DispatchQueue.main.async {
            loadingAlert.dismiss(animated: true, completion: nil)
            print("Loading alert dismissed.")
        }

        if let error = error {
            print("Error updating profile: \(error.localizedDescription)")
        } else {
            print("Profile updated successfully.")

            let updatedProfile = ProfileCell(
                uid: self.currentProfile?.uid ?? "",
                username: self.nameField.text ?? self.currentProfile?.username ?? "",
                userId: self.currentProfile?.userId ?? "",
                email: self.emailField.text ?? self.currentProfile?.email ?? "",
                profileImageUrl: imageUrl ?? self.currentProfile?.profileImageUrl ?? "",
                location: self.locationTextField.text ?? self.currentProfile?.location ?? "Not set",
                link: self.linkField.text ?? self.currentProfile?.link ?? "Not set"
            )

            // Notify the Profile screen
            print("Notifying the Profile screen about the update.")
            if let delegate = delegate {
                delegate.didUpdateProfile(with: updatedProfile)
            }

            // Go back to the Profile screen
            print("Popping back to the Profile screen.")
            self.navigationController?.popViewController(animated: true)
        }
    }

        

        
    // MARK: - UIImagePickerControllerDelegate
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let pickedImage = info[.originalImage] as? UIImage {
                profileImageView.image = pickedImage
            }
            dismiss(animated: true, completion: nil)
        }
    
}
