//
//  postViewModel.swift
//  Dazzle_New
//
//  Created by Steve on 08/02/25.
//

import FirebaseFirestore

class PostViewModel {
    var posts: [CommunityPost] = []

    func fetchPosts(completion: @escaping () -> Void) {
        let db = Firestore.firestore()
        
        // Real-time listener for the posts collection
        db.collection("posts")
            .order(by: "createdAt", descending: true)
            .addSnapshotListener { [weak self] snapshot, error in
                if let error = error {
                    print("Error fetching posts: \(error)")
                    return
                }

                guard let documents = snapshot?.documents else { return }
                
                var posts: [CommunityPost] = []
                
                let group = DispatchGroup()
                
                for document in documents {
                    group.enter()
                    
                    let postData = document.data()
                    let postUid = postData["uid"] as? String ?? ""
                    
                    // Fetch username and profileImageUrl from users collection using the post's uid
                    db.collection("users").document(postUid).getDocument { userSnapshot, error in
                        if let error = error {
                            print("Error fetching user data: \(error.localizedDescription)")
                            group.leave()
                            return
                        }

                        guard let userData = userSnapshot?.data() else {
                            group.leave()
                            return
                        }
                        
                        let username = userData["username"] as? String ?? "Anonymous"
                        let profileImageUrl = userData["profileImageUrl"] as? String ?? ""
                        
                        var post = CommunityPost(dictionary: postData)
                        post.username = username
                        post.profileImageUrl = profileImageUrl
                        
                        posts.append(post)
                        group.leave()
                    }
                }
                
                group.notify(queue: .main) {
                    self?.posts = posts
                    completion()
                }
            }
    }
    
    

}
