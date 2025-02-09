//
//  UserProfile2ViewController.swift
//  Dazzle
//
//  Created by Sunny on 18/11/24.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import SDWebImage

extension Notification.Name {
    static let profileUpdated = Notification.Name("profileUpdated")
}

class UserProfile2ViewController: UIViewController{
    
    
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    
    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var collectionView2: UICollectionView!
    
    @IBOutlet weak var collectionView3: UICollectionView!
    
    
    
    
    var profileCells: [ProfileCell] = []
    
    
        // MARK: - Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
            fetchUserData()
            
            // Assume we have a button or method that will present the EditProfileViewController
                    let editProfileVC = EditProfileViewController()
                    editProfileVC.delegate = self  // Set the delegate
            
            
            if self.navigationController == nil {
                    print("No navigation controller found")
                } else {
                    print("Navigation controller is set up")
                }
        }
        
    
   
   
    

    
    
    
        // MARK: - UI Setup
        func setupUI() {
            // Make profile image circular
            profileImage.layer.cornerRadius = profileImage.frame.size.height / 2
            profileImage.clipsToBounds = true
            
            // Configure collection views
                       collectionView1.delegate = self
                       collectionView1.dataSource = self
                       collectionView1.collectionViewLayout = createCompositionalLayout()
                       
                       collectionView2.isHidden = true
                       collectionView2.delegate = self
                       collectionView2.dataSource = self
                       collectionView2.collectionViewLayout = UICollectionViewFlowLayout()
                       
                       collectionView3.isHidden = true
                       collectionView3.delegate = self
                       collectionView3.dataSource = self
                       collectionView3.collectionViewLayout = UICollectionViewFlowLayout()
        }
        
        func configureCollectionView(_ collectionView: UICollectionView) {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.collectionViewLayout = createCompositionalLayout()
        }
        
    
    
    
    
    
    // MARK: - Fetch User Data
       func fetchUserData() {
           // Get the logged-in user's UID
           guard let userID = Auth.auth().currentUser?.uid else {
               print("User is not logged in")
               return
           }
           
           // Reference to Firestore
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
               
            
               // Fetch data and set default values for missing fields
               let userId = data["userId"] as? String ?? "@unknown"
               let username = data["username"] as? String ?? "No Name"
               let profileImageUrl = data["profileImageUrl"] as? String
               
               // Update the UI
               self.updateProfileView(userId: userId, username: username, profileImageUrl: profileImageUrl)
               
               
               // Fetch Profile Collection Data
                          self.fetchProfileDetails(userID: userID)
           }
       }
    
    
    // MARK: - Fetch Profile Collection Data (Location & Link)
    func fetchProfileDetails(userID: String) {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userID)

        userRef.getDocument(source: .default) { [weak self] (document, error) in
            
            guard let self = self else { return }

            if let error = error {
                print("Error fetching profile details: \(error.localizedDescription)")
                return
            }

            guard let document = document, document.exists, let data = document.data() else {
                print("User document does not exist")
                return
            }

            // Extract required data from Firestore document
            let uid = data["uid"] as? String ?? "Not set"
            let username = data["username"] as? String ?? "Not set"
            let userId = data["userId"] as? String ?? "Not set"
            let email = data["email"] as? String ?? "Not set"
            let profileImageUrl = data["profileImageUrl"] as? String ?? "Not set"
            
            // Extract location and link (these may not be in Firestore)
            let location = data["location"] as? String ?? "Not set"
            let link = data["link"] as? String ?? "Not set"

            // Create ProfileCell with the fetched data
            let profileCell = ProfileCell(uid: uid, username: username, userId: userId, email: email, profileImageUrl: profileImageUrl, location: location, link: link)

            self.profileCells = [profileCell] // Assuming profileCells is an array of ProfileCell objects
            self.collectionView1.reloadData() // Make sure collectionView1 is correctly connected
        }
    }

    


    
    
    
    // MARK: - Update Main Profile UI
        func updateProfileView(userId: String, username: String, profileImageUrl: String?) {
            nameLabel.text = username
            idLabel.text = "@\(userId)"

            if let profileImageUrl = profileImageUrl, let url = URL(string: profileImageUrl) {
                   // Use SDWebImage to asynchronously load and cache the image
                   profileImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder_image"))
                   profileImage.layer.cornerRadius = self.profileImage.frame.height / 2
                   profileImage.clipsToBounds = true
               }
            
            // Notify other parts of the app that the profile has been updated
                NotificationCenter.default.post(name: .profileUpdated, object: nil)
        }
    
    
    
    // MARK: - Segmented Control
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        collectionView1.isHidden = sender.selectedSegmentIndex != 0
                collectionView2.isHidden = sender.selectedSegmentIndex != 1
                collectionView3.isHidden = sender.selectedSegmentIndex != 2
            }
    
    
    // MARK: - Compositional Layout
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            if sectionIndex == 0 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
                return section
            } else if sectionIndex == 1 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
                return section
            } else {
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(80), heightDimension: .absolute(150))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(80), heightDimension: .absolute(150))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                section.interGroupSpacing = 10
                return section
            }
                
            
        }
        
        return layout
    }
    
    
    
}

extension UserProfile2ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == collectionView1 {
            return 3
        } else if collectionView == collectionView2 {
            return 1
        } else {
            return 1
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
            if collectionView == collectionView1 {
                if section == 0 {
                    return profileCells.count
                } else if section == 1 {
                    return yours.count
                } else {
                    return friends.count
                }
            } else if collectionView == collectionView2 {
                return designs.count
            } else {
                return posts.count
            }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionView1 {
            if indexPath.section == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as! ProfileCollectionViewCell
                
                let profileCell = profileCells[indexPath.row] // Get the current profile
                
                // Set up the cell with profile data
                cell.userId.text = "UserId: @\(profileCell.userId)"
                cell.UsernameLabel.text = "Username: \(profileCell.username)"
                cell.locationLabel.text = "Location: \(profileCell.location ?? "not set")"
                cell.linkLabel.text = "Link: \(profileCell.link ?? "not set")"
                            
                
                //MARK: EDIT BUTTON TAPPED
                // Set the closure for handling the edit button tap
                cell.onEditButtonTapped = {
                    // When the edit button is tapped, navigate to the EditProfileViewController
                    print("Edit button tapped. Attempting to present EditProfileViewController.")
                    if let editProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as? EditProfileViewController {
                        
                        // Ensure you have the profileCell data ready
                        print("Passing profile data: \(profileCell.username), \(profileCell.email)")
                        
                        // Pass the profile data to the EditProfileViewController
                        editProfileVC.currentProfile = profileCell
                        
                        // Set the delegate to handle profile updates
                        editProfileVC.delegate = self  // 'self' should be UserProfileViewController
                        
                        // Create a navigation controller with the edit profile view controller
//                        let navController = UINavigationController(rootViewController: editProfileVC)
                        //let navController = UINavigationController(rootViewController: self)
                        // Present the navigation controller
                        print("Presenting EditProfileViewController.")
                        
                        self.navigationController?.pushViewController(editProfileVC, animated: true)
                    }
                }
                return cell
            }
        

                else if indexPath.section == 1 {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YoursFriendsCollectionViewCell", for: indexPath) as! YoursFriendsCollectionViewCell
                    cell.setup(with: yours[indexPath.row])
                    return cell
                } else {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendsCollectionViewCell", for: indexPath) as! FriendsCollectionViewCell
                    cell.setup(with: friends[indexPath.row])
                    return cell
                }
            } else if collectionView == collectionView2 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DesignsCollectionViewCell", for: indexPath) as! DesignsCollectionViewCell
                cell.setup(with: designs[indexPath.row])
                cell.layer.cornerRadius = 10
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostsCollectionViewCell", for: indexPath) as! PostsCollectionViewCell
                cell.setup(with: posts[indexPath.row])
                return cell
            }
            
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionView2 {
            return CGSize(width: 360, height: 250)
        } else {
            return CGSize(width: 360 , height:  400)
        }
        
    }
    
}

// MARK: - EditProfileDelegate
extension UserProfile2ViewController: EditProfileDelegate {
    
    func didUpdateProfile(with updatedProfile: ProfileCell) {
            print("Profile updated in UserProfileViewController.")
            
            // Assuming the updated profile is in the profileCells array, find and update it
            if let index = profileCells.firstIndex(where: { $0.uid == updatedProfile.uid }) {
                profileCells[index] = updatedProfile  // Update the profile in the data model

                // Update the main profile UI (username, userId, profile image in the view controller)
                updateProfileView(userId: updatedProfile.userId,
                                          username: updatedProfile.username,
                                          profileImageUrl: updatedProfile.profileImageUrl)
                
                
                // Reload the specific item in the collection view
                collectionView1.reloadItems(at: [IndexPath(item: index, section: 0)])  // Update only the relevant cell
            }
        }
}

