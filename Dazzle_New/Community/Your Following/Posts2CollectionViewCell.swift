//
//  PostsCollectionViewCell.swift
//  Dazzle
//
//  Created by Steve on 17/11/24.
//

import UIKit
import SDWebImage
import FirebaseAuth
import FirebaseFirestore

class Posts2CollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var profileImageView: UIImageView!
       @IBOutlet weak var usernameLabel: UILabel!
       @IBOutlet weak var timeAgoLabel: UILabel!
       @IBOutlet weak var postDescriptionLabel: UILabel!
       
    @IBOutlet weak var postImageCollectionView: UICollectionView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var bookmarkButton: UIButton!
    
    
    
    var postImages: [String] = []  // Array of image URLs

        override func awakeFromNib() {
            super.awakeFromNib()
            postImageCollectionView.delegate = self
            postImageCollectionView.dataSource = self
            
            // Register for profile update notifications
                    NotificationCenter.default.addObserver(self, selector: #selector(updateProfile), name: .profileUpdated, object: nil)
            
            
        }
    
    deinit {
           // Remove observer when the cell is deallocated
           NotificationCenter.default.removeObserver(self)
       }

       @objc func updateProfile() {
           // Fetch the latest profile details and update the UI
           loadProfileDetails()
       }
    
    func loadProfileDetails() {
        // Fetch updated profile info from Firestore
        let userRef = Firestore.firestore().collection("users").document(Auth.auth().currentUser!.uid)
        userRef.getDocument { snapshot, error in
            if let error = error {
                print("Error fetching profile: \(error.localizedDescription)")
                return
            }
            
            if let data = snapshot?.data() {
                let username = data["username"] as? String ?? ""
                let profileImageUrl = data["profileImageUrl"] as? String ?? ""
                
                // Update UI with the new profile details
                DispatchQueue.main.async {
                    self.usernameLabel.text = username
                    
                    // Clear memory cache before updating the profile image
                    SDImageCache.shared.clearMemory()
                    
                    if let url = URL(string: profileImageUrl) {
                        self.profileImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "defaultProfileImage"), options: [.refreshCached])
                    }
                }
            }
        }
    }



    func configure(with post: CommunityPost) {
        // Set username and description
        usernameLabel.text = post.username
        timeAgoLabel.text = post.timeAgo
        postDescriptionLabel.text = post.postDescription
        likeLabel.text = "\(post.likeCount) Likes"
        
        // Load profile image from URL
        if let url = URL(string: post.profileImageUrl) {
            profileImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "defaultProfileImage"), options: [.refreshCached])
        }
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true
        
        // Assign post images to the carousel
        self.postImages = post.postImages
        postImageCollectionView.reloadData()
    }

        // MARK: - Collection View Delegate & Data Source
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return postImages.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostImageCarousel", for: indexPath) as! PostImageCarousel
            cell.configure(with: postImages[indexPath.item])
            return cell
        }
   

}
