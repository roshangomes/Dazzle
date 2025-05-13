//
//  ProfilePostViewController.swift
//  Dazzle_New
//
//  Created by Steve on 17/03/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfilePostViewController: UIViewController {
    
    
    @IBOutlet weak var PostCollectionView: UICollectionView!
    
    let viewModel = PostViewModel()  // Using the modified PostViewModel
        var userPosts: [CommunityPost] = []  // Store user-specific posts
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupCollectionView()
            fetchUserPosts()
        }
        
        func setupCollectionView() {
            PostCollectionView.delegate = self
            PostCollectionView.dataSource = self
            
            
            
        }
        
        func fetchUserPosts() {
            viewModel.fetchPosts(userSpecific: true) { [weak self] in
                DispatchQueue.main.async {
                    self?.userPosts = self?.viewModel.posts ?? []
                    self?.PostCollectionView.reloadData()
                }
            }
        }
    }

    // MARK: - UICollectionView Delegate & DataSource
    extension ProfilePostViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return userPosts.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfilePostCell", for: indexPath) as! ProfilePostViewCell
            let post = userPosts[indexPath.item]
            cell.configure(with: post)  // Ensure ProfilePostViewCell has a `configure` method
            return cell
        }
    }

    // MARK: - UICollectionViewDelegateFlowLayout (for layout customization)
    extension ProfilePostViewController: UICollectionViewDelegateFlowLayout {
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = (collectionView.frame.width / 3) - 8  // 3 cells per row, with spacing
            return CGSize(width: width, height: width)
        }
    }
