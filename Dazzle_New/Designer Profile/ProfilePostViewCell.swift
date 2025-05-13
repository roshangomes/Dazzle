//
//  ProfilePostViewCell.swift
//  Dazzle_New
//
//  Created by Steve on 17/03/25.
//

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

class ProfilePostViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var ProfileImageView: UIImageView!
    @IBOutlet weak var UsernameLabel: UILabel!
    @IBOutlet weak var TimeAgoLabel: UILabel!

    @IBOutlet weak var BioLabel: UILabel!
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var LikeLabel: UILabel!
    
    @IBOutlet weak var commentButton: UIButton!
    
    @IBOutlet weak var CommentLabel: UILabel!
    
    @IBOutlet weak var ShareButton: UIButton!
    
    @IBOutlet weak var BookmarkButton: UIButton!
    
    
    var postImages: [String] = []  // Array of image URLs
    var post: CommunityPost?

        override func awakeFromNib() {
            super.awakeFromNib()
            imageCollectionView.delegate = self
            imageCollectionView.dataSource = self
            
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
                    self.UsernameLabel.text = username
                    
                    // Clear memory cache before updating the profile image
                    SDImageCache.shared.clearMemory()
                    
                    if let url = URL(string: profileImageUrl) {
                        self.ProfileImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "defaultProfileImage"), options: [.refreshCached])
                    }
                }
            }
        }
    }



    func configure(with post: CommunityPost) {
        
        self.post = post
        // Set username and description
        UsernameLabel.text = post.username
        TimeAgoLabel.text = post.timeAgo
        BioLabel.text = post.postDescription
        LikeLabel.text = "\(post.likeCount) Likes"
        
        // Load profile image from URL
        if let url = URL(string: post.profileImageUrl) {
            ProfileImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "defaultProfileImage"), options: [.refreshCached])
        }
        ProfileImageView.contentMode = .scaleAspectFill
        ProfileImageView.layer.cornerRadius = ProfileImageView.frame.width / 2
        ProfileImageView.clipsToBounds = true
        
        // Assign post images to the carousel
        self.postImages = post.postImages
        imageCollectionView.reloadData()
        
        // Set like button state
               updateLikeButton()
    }

    // MARK: - Like Button Action
        @IBAction func likeButtonTapped(_ sender: UIButton) {
            guard var post = post, let currentUserId = Auth.auth().currentUser?.uid else { return }
               let postRef = Firestore.firestore().collection("posts").document(post.postId)

               Firestore.firestore().runTransaction({ (transaction, errorPointer) -> Any? in
                   let postSnapshot: DocumentSnapshot
                   do {
                       try postSnapshot = transaction.getDocument(postRef)
                   } catch {
                       print("Error fetching post: \(error)")
                       return nil
                   }

                   guard var postData = postSnapshot.data() else { return nil }

                   var likes = postData["likes"] as? Int ?? 0
                   var likedUsers = postData["likedUsers"] as? [String] ?? []

                   if likedUsers.contains(currentUserId) {
                       // Unlike post
                       likes -= 1
                       likedUsers.removeAll { $0 == currentUserId }
                   } else {
                       // Like post
                       likes += 1
                       likedUsers.append(currentUserId)
                   }

                   // Update Firestore
                   postData["likes"] = likes
                   postData["likedUsers"] = likedUsers
                   transaction.setData(postData, forDocument: postRef)

                   // Modify the local post object safely after the transaction
                   post.likeCount = likes  // Update local property
                   post.isLiked = likedUsers.contains(currentUserId)  // Update local liked status

                   return nil
               }) { (object, error) in
                   if let error = error {
                       print("Error updating likes: \(error.localizedDescription)")
                   } else {
                       DispatchQueue.main.async {
                           // Safely update the UI
                           self.post = post  // Assign the updated post object
                           self.updateLikeButton()  // Update the like button UI
                       }
                   }
               }
        }

        // MARK: - Update Like Button UI
        func updateLikeButton() {
            if let post = post, post.isLiked {
                likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                likeButton.tintColor = .red
            } else {
                likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
                likeButton.tintColor = .gray
            }
            LikeLabel.text = "\(post?.likeCount ?? 0) Likes"
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

    
   
    

