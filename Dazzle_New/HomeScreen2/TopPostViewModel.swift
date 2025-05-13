import FirebaseFirestore

class TopPostViewModel {
    var topThreePosts: [Post] = []  // Store top 3 posts

    func fetchTopPosts(completion: @escaping () -> Void) {
        let db = Firestore.firestore()

        db.collection("posts")
            .order(by: "likes", descending: true) // Sort by likes
            .limit(to: 3) // Fetch only top 3
            .getDocuments(completion: { snapshot, error in
                if let error = error {
                    print("🔥 Error fetching posts: \(error.localizedDescription)")
                    return
                }

                guard let documents = snapshot?.documents else {
                    print("⚠️ No posts found in Firestore.")
                    return
                }

                print("✅ Retrieved \(documents.count) posts")  // Debugging output

                self.topThreePosts = documents.compactMap { document in
                    let data = document.data()
                    
                    // Extract necessary fields
                    let id = document.documentID
                    let title = "Top Post"  // Placeholder title (not present in Firestore)
                    let desc = data["description"] as? String ?? ""
                    let likes = data["likes"] as? Int ?? 0
                    let imageUrls = data["imageUrls"] as? [String] ?? []
                    
                    // Use first image URL (if available)
                    let imageUrl = imageUrls.first ?? ""

                    return Post(
                        id: id,
                        title: title,
                        desc: desc,
                        likes: likes,
                        imageUrl: imageUrl
                    )
                }

                completion()
            })
    }
}
