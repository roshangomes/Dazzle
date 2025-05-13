//
//  TopUsersViewModel.swift
//  Dazzle_New
//
//  Created by Steve on 11/03/25.
//

import FirebaseFirestore

class TopUserViewModel {
    var topUsers: [Creator] = []  // Store top users

    func fetchTopUsers(completion: @escaping () -> Void) {
        let db = Firestore.firestore()

        db.collection("posts").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching posts: \(error)")
                return
            }

            guard let documents = snapshot?.documents else { return }

            var userPostCounts: [String: Int] = [:]

            for document in documents {
                let data = document.data()
                if let uid = data["uid"] as? String {
                    userPostCounts[uid, default: 0] += 1
                }
            }

            let sortedUsers = userPostCounts.sorted { $0.value > $1.value }
            let userIDs = sortedUsers.prefix(3).map { $0.key }

            var fetchedUsers: [Creator] = []
            let group = DispatchGroup()

            for uid in userIDs {
                group.enter()
                db.collection("users").document(uid).getDocument { userSnapshot, error in
                    defer { group.leave() }

                    if let userSnapshot = userSnapshot, userSnapshot.exists {
                        let userData = userSnapshot.data()
                        let user = Creator(
                            id: uid,
                            name: userData?["username"] as? String ?? "Unknown",  // Use "username" instead of "name"
                            profileImage: userData?["profileImageUrl"] as? String ?? "", // Use "profileImageUrl"
                            postCount: userPostCounts[uid] ?? 0
                        )
                        fetchedUsers.append(user)
                    } else {
                        print("User document not found for UID: \(uid)")
                    }
                }
            }

            group.notify(queue: .main) {
                self.topUsers = fetchedUsers
                completion()
            }
        }
    }
}
