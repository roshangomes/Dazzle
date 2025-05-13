import FirebaseFirestore

class LeaderboardViewModel {
    var topThreeUsers: [LeaderboardUser] = []  // Store only top 3 users

    func fetchLeaderboard(completion: @escaping () -> Void) {
        let db = Firestore.firestore()

        db.collection("users").getDocuments { userSnapshot, error in
            if let error = error {
                print("Error fetching users: \(error)")
                return
            }

            guard let userDocs = userSnapshot?.documents else { return }

            var leaderboard: [String: LeaderboardUser] = [:]  // 🔹 Dictionary to store users by UID

            // 1️⃣ Fetch user data first
            for document in userDocs {
                let data = document.data()
                let uid = document.documentID
                let username = data["username"] as? String ?? "Unknown"
                let profileImageUrl = data["profileImageUrl"] as? String ?? ""
                let userLikes = data["totalLikes"] as? Int ?? 0  // From "users" collection

                leaderboard[uid] = LeaderboardUser(
                    uid: uid,
                    name: username,
                    image: profileImageUrl,
                    likes: userLikes
                )
            }

            // 2️⃣ Now fetch likes from "posts"
            db.collection("posts").getDocuments { postSnapshot, error in
                if let error = error {
                    print("Error fetching posts: \(error)")
                    return
                }

                guard let postDocs = postSnapshot?.documents else { return }

                for post in postDocs {
                    let postData = post.data()
                    let postOwnerUID = postData["uid"] as? String ?? ""  // Ensure 'uid' is stored in posts
                    let postLikes = postData["likes"] as? Int ?? 0

                    // Add post likes to the corresponding user
                    if var user = leaderboard[postOwnerUID] {
                        user.likes += postLikes  // 🔹 Sum likes from posts
                        leaderboard[postOwnerUID] = user
                    }
                }

                // 3️⃣ Convert dictionary to array and sort by highest likes
                self.topThreeUsers = leaderboard.values.sorted { $0.likes > $1.likes }.prefix(3).map { $0 }

                print("🏆 Updated Leaderboard:", self.topThreeUsers) // 🛠 Debugging Print

                completion()
            }
        }
    }
}
