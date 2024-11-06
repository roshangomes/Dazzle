//
//  Datamodel.swift
//  Dazzle
//
//  Created by Steve on 03/11/24.
//

import UIKit

struct TShirtDesign {
    let id: String
    let title: String
    let creatorUsername: String    
    let price: Double              // Price of the design
    let imageName: String           // URL of the design's image (for loading from the web)
    let isFavorited: Bool          // Whether the design is favorited by the user
    
    // Additional properties, if need
    let description: String?       // Description of the design
}

struct User {
    var username: String
    var profileImageName: String // Assuming profile images are locally stored; otherwise, use URL if fetched from a server.
}

struct CommunityPost {
    var user: User
    var timeAgo: String
    var textContent: String
    var hashtags: [String]
    var images: String // Image names or URLs of images in the post.
    var likeCount: Int
    var replyCount: Int
    var shareCount: Int
}


class Datamodel {
    static var sampleDesigns = [
        TShirtDesign(id: "1", title: "The Raging Wolf", creatorUsername: "@sarah2201", price: 700, imageName:"Design1", isFavorited: false, description: nil),
        TShirtDesign(id: "2", title: "The Breathing Forest", creatorUsername: "@itzmevic", price: 650, imageName: "Design3", isFavorited: true, description: nil),
        TShirtDesign(id: "3", title: "Space Splash", creatorUsername: "@artlover", price: 800, imageName: "Design5", isFavorited: false, description: nil),
        TShirtDesign(id: "4", title: "Abstract Waves", creatorUsername: "@waveartist", price: 750, imageName: "Design6", isFavorited: true, description: nil),
        TShirtDesign(id: "1", title: "The Raging Wolf", creatorUsername: "@sarah2201", price: 700, imageName:"Design1", isFavorited: false, description: nil),
        TShirtDesign(id: "2", title: "The Breathing Forest", creatorUsername: "@itzmevic", price: 650, imageName: "Design3", isFavorited: true, description: nil),
        TShirtDesign(id: "3", title: "Space Splash", creatorUsername: "@artlover", price: 800, imageName: "Design5", isFavorited: false, description: nil),
        TShirtDesign(id: "4", title: "Abstract Waves", creatorUsername: "@waveartist", price: 750, imageName: "Design6", isFavorited: true, description: nil)
    ]
    
    var samplePosts: [Post] = [
            Post(
                user: User(username: "Wade Warren", profileImageName: "profileImage1"),
                timeAgo: "56 minutes ago",
                textContent: "Thought of a new idea and put it in my new design.",
                hashtags: ["#art", "#howisit", "#aesthetics"],
                images: ["wolf_design1", "wolf_design2"],
                likeCount: 120,
                replyCount: 45,
                shareCount: 20
            ),
            Post(
                user: User(username: "Sarah Bennett", profileImageName: "profileImage2"),
                timeAgo: "1 hour ago",
                textContent: "Check out my latest t-shirt design inspired by nature!",
                hashtags: ["#nature", "#design", "#fashion"],
                images: ["nature_shirt1", "nature_shirt2"],
                likeCount: 200,
                replyCount: 60,
                shareCount: 30
            )
        ]
}
