//
//  uploadViewController.swift
//  Dazzle_New
//
//  Created by Steve on 19/01/25.
//

import UIKit
import PhotosUI
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class uploadViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, PHPickerViewControllerDelegate,UITextViewDelegate {
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var postdescriptionText: UITextView!
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    @IBOutlet weak var chooseImageButton: UIButton!
    
    @IBOutlet weak var uploadButton: UIButton!
    
    var selectedImages: [UIImage] = []
       let db = Firestore.firestore()
       let storage = Storage.storage().reference()
       var currentUser: User? // Assume you pass the logged-in user details here
    var username: String = ""
       var profileImageUrl: String = ""
       
       
    
    
       override func viewDidLoad() {
           super.viewDidLoad()
           
           postdescriptionText.delegate = self
           postdescriptionText.text = "Write a description..."
           postdescriptionText.textColor = UIColor.lightGray
           
           photosCollectionView.dataSource = self
           photosCollectionView.delegate = self
           
           if let layout = photosCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
               layout.scrollDirection = .horizontal
               layout.minimumLineSpacing = 10
               layout.itemSize = CGSize(width: 100, height: 100)
           }
           
           // Fetch user details
        fetchUserDetails()
           profileimg()
           
           
       }
    
    func profileimg(){
        userProfileImageView.layer.cornerRadius = userProfileImageView.frame.size.height / 2
        userProfileImageView.clipsToBounds = true
    }
    
    
    
    // Fetch user details from Firestore
        func fetchUserDetails() {
            guard let userId = Auth.auth().currentUser?.uid else {
                print("No logged-in user.")
                return
            }
            
            db.collection("users").document(userId).getDocument { [weak self] (snapshot, error) in
                guard let self = self else { return }
                if let error = error {
                    print("Error fetching user details: \(error.localizedDescription)")
                    return
                }
                
                if let data = snapshot?.data() {
                    self.username = data["username"] as? String ?? "Anonymous"
                    self.profileImageUrl = data["profileImageUrl"] as? String ?? ""
                    self.usernameLabel.text = self.username
                    
                    if let url = URL(string: self.profileImageUrl) {
                        self.userProfileImageView.loadImage(from: url)
                    }
                }
            }
        }
    
    // Handle placeholder when editing begins
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == "Write a description..." {
                textView.text = ""
                textView.textColor = UIColor.black // Change to your desired text color
            }
        }
        
        // Handle placeholder when editing ends
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = "Write a description..."
                textView.textColor = UIColor.lightGray
            }
        }

    
       
       @IBAction func chooseImageButtonTapped(_ sender: UIButton) {
           var config = PHPickerConfiguration()
           config.selectionLimit = 0 // 0 for unlimited selection; adjust if needed
           config.filter = .images // Only allow image selection
           
           let picker = PHPickerViewController(configuration: config)
           picker.delegate = self
           present(picker, animated: true, completion: nil)
       }
       
       @IBAction func uploadButtonTapped(_ sender: UIButton) {
           guard !selectedImages.isEmpty else {
                       showAlert(message: "Please select at least one image.")
                       return
                   }
                   
                   guard postdescriptionText.text != "Write a description...", !postdescriptionText.text.isEmpty else {
                       showAlert(message: "Please write a description for your post.")
                       return
                   }
                   
                   uploadPostToFirebase()
               }
    
    
    var loadingPopup: UIView!
    var activityIndicator: UIActivityIndicatorView!
    var loadingLabel: UILabel!

    func createLoadingPopup() {
        // Create a view for the loading popup with rounded corners and shadow
        loadingPopup = UIView(frame: CGRect(x: 0, y: 0, width: 220, height: 120))
        loadingPopup.center = view.center
        loadingPopup.backgroundColor = .black
        loadingPopup.alpha = 0.9
        loadingPopup.layer.cornerRadius = 15
        loadingPopup.layer.shadowColor = UIColor.black.cgColor
        loadingPopup.layer.shadowOffset = CGSize(width: 0, height: 4)
        loadingPopup.layer.shadowRadius = 8
        loadingPopup.layer.shadowOpacity = 0.3
        
        // Create a label to show the loading message with better font and spacing
        loadingLabel = UILabel(frame: CGRect(x: 0, y: 20, width: 220, height: 30))
        loadingLabel.text = "Uploading..."
        loadingLabel.textColor = .white
        loadingLabel.textAlignment = .center
        loadingLabel.font = UIFont.boldSystemFont(ofSize: 18)
        loadingLabel.adjustsFontSizeToFitWidth = true
        loadingLabel.numberOfLines = 1
        loadingPopup.addSubview(loadingLabel)
        
        // Create the activity indicator with custom styling
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.center = CGPoint(x: loadingPopup.frame.width / 2, y: loadingPopup.frame.height / 2 + 10)
        activityIndicator.startAnimating()
        loadingPopup.addSubview(activityIndicator)
        
        // Add a fade-in animation to the popup
        loadingPopup.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.loadingPopup.alpha = 1
        }
        
        // Add the loading popup to the main view
        view.addSubview(loadingPopup)
    }


    func showLoadingPopup() {
        createLoadingPopup() // Create and show the loading popup
    }


    func hideLoadingPopup() {
        loadingPopup.removeFromSuperview() // Remove the loading popup from the view
    }

    
    func uploadPostToFirebase() {
            var uploadedImageUrls: [String] = []
            let group = DispatchGroup()
        
        // Show loading popup
            showLoadingPopup()
            
            for (index, image) in selectedImages.enumerated() {
                group.enter()
                let imageRef = storage.child("posts/\(UUID().uuidString)_\(index).jpg")
                
                guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                    print("Failed to compress image.")
                    group.leave()
                    continue
                }
                
                imageRef.putData(imageData, metadata: nil) { _, error in
                    if let error = error {
                        print("Error uploading image: \(error.localizedDescription)")
                        group.leave()
                        return
                    }
                    
                    imageRef.downloadURL { url, error in
                        if let url = url {
                            uploadedImageUrls.append(url.absoluteString)
                        } else if let error = error {
                            print("Error getting image URL: \(error.localizedDescription)")
                        }
                        group.leave()
                    }
                }
            }
            
            group.notify(queue: .main) {
                // Hide loading popup once upload is complete
                        self.hideLoadingPopup()
                        
                self.savePostToFirestore(imageUrls: uploadedImageUrls)
            }
        }
        
        func savePostToFirestore(imageUrls: [String]) {
            guard let userId = Auth.auth().currentUser?.uid else { return }
            let postData: [String: Any] = [
                "uid": userId,
                
                "description": postdescriptionText.text ?? "",
                "imageUrls": imageUrls,
                "createdAt": FieldValue.serverTimestamp(),
                "likes": 0
            ]
            
            db.collection("posts").addDocument(data: postData) { error in
                if let error = error {
                    self.showAlert(message: "Failed to upload post: \(error.localizedDescription)")
                } else {
                    self.showAlert(message: "Post uploaded successfully!")
                    self.resetPostForm()
                }
            }
        }
        
        func resetPostForm() {
            selectedImages.removeAll()
            photosCollectionView.reloadData()
            postdescriptionText.text = "Write a description..."
            postdescriptionText.textColor = UIColor.lightGray
        }
        
        func showAlert(message: String) {
            let alert = UIAlertController(title: "Dazzle", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true, completion: nil)
            
            for result in results {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                        guard let self = self else { return }
                        if let image = image as? UIImage {
                            DispatchQueue.main.async {
                                self.selectedImages.append(image)
                                self.photosCollectionView.reloadData()
                            }
                        } else if let error = error {
                            print("Error loading image: \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return selectedImages.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionViewCell
            cell.imageCarouseImageView.image = selectedImages[indexPath.item]
            return cell
        }
    }

    // UIImageView extension to load image from URL
    extension UIImageView {
        func loadImage(from url: URL) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
   }
