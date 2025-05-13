import FirebaseFirestore
import FirebaseAuth

class PostViewModel {
    var posts: [CommunityPost] = []

    func fetchPosts(userSpecific: Bool = false,completion: @escaping () -> Void) {
        let db = Firestore.firestore()
               let postCollection = db.collection("posts")
               
               var query: Query = postCollection.order(by: "createdAt", descending: true)

               // 🔹 If fetching user-specific posts, filter by current user UID
               if userSpecific, let currentUserId = Auth.auth().currentUser?.uid {
                   query = query.whereField("uid", isEqualTo: currentUserId)
               }

               query.addSnapshotListener { [weak self] snapshot, error in
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
                    let postId = document.documentID
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
                        
                        // Use the Firestore document snapshot instead of just passing postId
                        let currentUserId = Auth.auth().currentUser?.uid ?? ""  // ✅ Define user ID
                        var post = CommunityPost(document: document, currentUserId: currentUserId)
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
