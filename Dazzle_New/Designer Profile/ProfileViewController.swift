//
//  ProfileViewController.swift
//  Dazzle_New
//
//  Created by Steve on 16/02/25.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import SDWebImage



extension Notification.Name {
    static let profileUpdated = Notification.Name("profileUpdated")
}


class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileCoverImageView: UIImageView!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var userIDLabel: UILabel!
    
    @IBOutlet weak var editProfileButton: UIButton!
    
    @IBOutlet weak var settingButton: UIButton!
    
    
    @IBOutlet weak var detailsTitleLabel: UILabel!
    
    @IBOutlet weak var linkDisplayImageView: UIImageView!
    
    @IBOutlet weak var linkLabel: UILabel!
    
    @IBOutlet weak var emailImageView: UIImageView!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var locationDisplayImageView: UIImageView!
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    
    @IBOutlet weak var desipostsCollectionView: UICollectionView!
    
    
    let viewModel = PostViewModel()
        var profileCell: ProfileCell?
    
    private let noPostsLabel: UILabel = {
        let label = UILabel()
        label.text = "No Posts Yet"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.isHidden = true  // Initially hidden
        return label
    }()
        
    // MARK: - Lifecycle
       override func viewDidLoad() {
           super.viewDidLoad()
           setupUI()
           setupCollectionView()
           
           // Initially hide collection view until we know if there are posts
              desipostsCollectionView.isHidden = true
              noPostsLabel.isHidden = false // Start with "No Posts" visible
              
           fetchUserData()
           fetchPosts()
           print("View did load")
           setupNoPostsLabel()
           print("Collection View frame: \(desipostsCollectionView.frame)")
           print("Number of items in section: \(viewModel.posts.count)")
           desipostsCollectionView.collectionViewLayout = UICollectionViewFlowLayout() // Ensure layout is set
           // Observe profile updates
           NotificationCenter.default.addObserver(self, selector: #selector(handleProfileUpdate), name: .profileUpdated, object: nil)
       }
    
    private func setupNoPostsLabel() {
        view.addSubview(noPostsLabel)
        noPostsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            noPostsLabel.topAnchor.constraint(equalTo: postTitleLabel.bottomAnchor, constant: 60),
            noPostsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Don't hide it here - let the fetchPosts method determine visibility
    }

    // MARK: - UI Setup
        func setupUI() {
            profileImage.layer.cornerRadius = profileImage.frame.height / 2
            profileImage.clipsToBounds = true
        }
        
        func setupCollectionView() {
            desipostsCollectionView.delegate = self
            desipostsCollectionView.dataSource = self
            
        }

        // MARK: - Fetch User Data
        func fetchUserData() {
            guard let userID = Auth.auth().currentUser?.uid else {
                print("User not logged in")
                return
            }
            
            let db = Firestore.firestore()
            db.collection("users").document(userID).getDocument { [weak self] (document, error) in
                guard let self = self else { return }
                if let error = error {
                    print("Error fetching user data: \(error.localizedDescription)")
                    return
                }
                guard let document = document, document.exists, let data = document.data() else {
                    print("User document does not exist")
                    return
                }

                let uid = data["uid"] as? String ?? "Not set"
                let userId = data["userId"] as? String ?? "@unknown"
                let username = data["username"] as? String ?? "No Name"
                let email = data["email"] as? String ?? "Not set"
                let profileImageUrl = data["profileImageUrl"] as? String
                let location = data["location"] as? String ?? "Not set"
                let link = data["link"] as? String ?? "Not set"

                self.profileCell = ProfileCell(uid: uid, username: username, userId: userId, email: email, profileImageUrl: profileImageUrl ?? "Not Provided", location: location, link: link)
                self.updateProfileView()
            }
        }

        // MARK: - Update Profile UI
        func updateProfileView() {
            guard let profile = profileCell else { return }

            usernameLabel.text = profile.username.isEmpty ? "No Name" : profile.username
            userIDLabel.text = "@\(profile.userId.isEmpty ? "unknown" : profile.userId)"
            locationLabel.text = profile.location ?? "Not set"
            linkLabel.text = profile.link ?? "Not set"

            if let url = URL(string: profile.profileImageUrl) {
                profileImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder_image"))
            } else {
                profileImage.image = UIImage(named: "placeholder_image")
            }
        }

    // MARK: - Fetch Posts
    func fetchPosts() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        viewModel.fetchPosts(userSpecific: true) { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                print("Posts fetched: \(self.viewModel.posts.count)")
                
                if self.viewModel.posts.isEmpty {
                    self.noPostsLabel.isHidden = false
                    self.desipostsCollectionView.isHidden = true
                } else {
                    self.noPostsLabel.isHidden = true
                    self.desipostsCollectionView.isHidden = false
                }
                
                self.desipostsCollectionView.reloadData()
            }
        }
    }

        // MARK: - Handle Profile Update
        @objc func handleProfileUpdate() {
            fetchUserData()
        }

        @IBAction func editProfileTapped(_ sender: UIButton) {
            if let editProfileVC = storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as? EditProfileViewController {
                editProfileVC.currentProfile = profileCell
                editProfileVC.delegate = self
                navigationController?.pushViewController(editProfileVC, animated: true)
            }
        }
    }

// MARK: - Edit Profile Delegate
extension ProfileViewController: EditProfileDelegate {
    func didUpdateProfile(with updatedProfile: ProfileCell) {
        profileCell = updatedProfile
        updateProfileView()
        NotificationCenter.default.post(name: .profileUpdated, object: nil)
    }
}

// MARK: - Collection View Delegate & Data Source
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.posts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostViewCell", for: indexPath) as? PostViewCell else {
            fatalError("❌ Could not dequeue PostViewCell! Check Storyboard Identifier.")
        }

        let post = viewModel.posts[indexPath.item]
        if let url = URL(string: post.postImages.first ?? "") {
            cell.postImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        }

        return cell
    }

    // Set grid layout like Instagram
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 3) - 1 // 3-column grid
        return CGSize(width: width, height: width)
    }

    // Add spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
        
    
    
}
