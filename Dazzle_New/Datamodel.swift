//
//  Datamodel.swift
//  Dazzle
//
//  Created by Steve on 03/11/24.
//

import UIKit

struct Static {
    let image : UIImage
}

let statics : [Static] = [
    Static(image: UIImage(named: "Home")!)
    ]


struct TopLabel {
    let title : String
}

let tops : [TopLabel] = [
    TopLabel(title: "Popular Designs")
    ]
    

struct Popular {
    
    let title : String
    let name : String
    let image : UIImage
}

struct PopLabel {
    let title : String
    
}

struct Creator {
    let title : String
    let design : String
    let image : UIImage
}

struct LeaderBLabel {
    let title : String
    
}

struct Leader {
    let title : String
    let desc : String
    let image : UIImage
    let likes : String
}


struct CartItem {
    let image: UIImage
    let name: String
    let color: String
    let type: String
    let size: String
    var rank: String
    let money : String
    
}

struct MyOrder {
    let image : UIImage
    let name : String
    let date : String
    let status : String
    let money : String
}

struct ProfileCell1 {
    let name1: String
    let username1: String
    
}

struct Your {
    let title : String
    
}

struct Friend {
    let image : UIImage
    let name : String
    let designs : String
}

struct Design {
    let title: String
    let imageName: UIImage
}

struct Post {
    let profileImage : UIImage
    let name : String
    let time : String
    let desc : String
    let hashtag : String
    let postImage : UIImage
    
}


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
struct UserLogin{
    var name:String
    var email:String
    var password:String
}
struct User {
    var username: String
    var profileImageName: UIImage
    var makepostLabel: String
    var photoUrl: String?
}

struct CommunityPost {
    var username: String
    var uid: String
    var profileImageUrl: String
    var timeAgo: String
    var postDescription: String
    var likeCount: Int
    var postImages: [String]  // Array of image URLs
    

    init(dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? "Unknown"
        self.uid = dictionary["uid"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.timeAgo = "Just now"  // You can convert timestamp later
        self.postDescription = dictionary["description"] as? String ?? ""
        self.likeCount = dictionary["likes"] as? Int ?? 0
        self.postImages = dictionary["imageUrls"] as? [String] ?? []
    }
    
    static func timeAgoSinceDate(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let calendar = Calendar.current
            let now = Date()
            let components = calendar.dateComponents([.minute, .hour, .day, .weekOfYear, .month, .year], from: date, to: now)

            if let year = components.year, year >= 1 {
                return "\(year)y ago"
            } else if let month = components.month, month >= 1 {
                return "\(month)mo ago"
            } else if let week = components.weekOfYear, week >= 1 {
                return "\(week)w ago"
            } else if let day = components.day, day >= 1 {
                return "\(day)d ago"
            } else if let hour = components.hour, hour >= 1 {
                return "\(hour)h ago"
            } else if let minute = components.minute, minute >= 1 {
                return "\(minute)m ago"
            } else {
                return "Just now"
            }
        }
}
struct Leaderboard {
    let rank: Int
    let username: String
    let profileImage: UIImage?
    let likes: Int
    let designImage: String
    let bio: String?
    let title: String?
}
struct LeaderboardUser {
    let name: String         // User's name
    let image: UIImage       // User's profile image
    let likes: Int           // Number of likes or points
}

struct LeaderboardEntry {
    var firstUser: LeaderboardUser
    var secondUser: LeaderboardUser
    var thirdUser: LeaderboardUser
}

import Foundation

struct ProfileCell {
    let uid: String
    let username: String
    let userId: String
    let email: String
    let profileImageUrl: String
    var location: String? // Not in Firebase initially
    var link: String? // Not in Firebase initially
}


extension LeaderboardEntry {
    mutating func updateRanking(with users: [LeaderboardUser]) {
        let sortedUsers = users.sorted { $0.likes > $1.likes }
        
        // Update rankings
        if sortedUsers.count > 0 {
            firstUser = sortedUsers[0]
        }
        if sortedUsers.count > 1 {
            secondUser = sortedUsers[1]
        }
        if sortedUsers.count > 2 {
            thirdUser = sortedUsers[2]
        }
    }
}

struct Designer {
    let id: String // Unique identifier
    let name: String // Designer's name
    let profileImageName: String // Image file name or URL
    let isContactable: Bool // Whether the "Contact" button is enabled
    var bio: String
    var postcount: Int
    var followcount: Int
    var followingcount: Int
}
struct ConnectPeople {
    let id: String // Unique identifier
    let name: String // Designer's name
    let profileImageName: String // Image file name or URL
    
}

let populars : [Popular] = [
    
    Popular(title: "The Breathing Forest", name: "@itzmevic", image: UIImage(named: "Design1")!),
    Popular(title: "Make for the World", name: "@itzmevic", image: UIImage(named: "Design2")!),
    Popular(title: "Live your Life  Way", name: "@itzmevic", image: UIImage(named: "Design3")!),
    Popular(title: "The Dazzling Dangle", name: "@itzmevic", image: UIImage(named: "Design4")!),
    Popular(title: "Heppy Happy", name: "@itzmevic", image: UIImage(named: "Design5")!)
]



let pops : [PopLabel] = [
    PopLabel(title: "Top Creators")
    ]




let creators : [Creator] = [
    Creator(title: "Jay Robe", design: "20 Designs", image: UIImage(named: "profile1")!),
    Creator(title: "Jay Robe", design: "20 Designs", image: UIImage(named: "profile5")!),
    Creator(title: "Jay Robe", design: "20 Designs", image: UIImage(named: "profile4")!),
    Creator(title: "Jay Robe", design: "20 Designs", image: UIImage(named: "profile3")!),
    Creator(title: "Jay Robe", design: "20 Designs", image: UIImage(named: "profile2")!),
    ]



let leadsB : [LeaderBLabel] = [
    LeaderBLabel(title: "Leader Board")
    ]



let leaders : [Leader] = [
    Leader(title: "The Rumbling Forest", desc: "Had the idea of a forest that would be able to rumble and shake the earth.", image: UIImage(named: "Design2")!, likes: "100"),
    Leader(title: "The Rumbling Forest", desc: "Had the idea of a forest that would be able to rumble and shake the earth.", image: UIImage(named: "Design6")!, likes: "100"),
    Leader(title: "The Rumbling Forest", desc: "Had the idea of a forest that would be able to rumble and shake the earth.", image: UIImage(named: "Design4")!, likes: "100")
    ]



var cartItems: [CartItem] = [
    CartItem(image: UIImage(named: "Design3")!, name: "King Pride", color: "Color : Grey", type: "95% Polyester, 5% Elastane", size: "Size : M", rank: "Leaderboard Rank : 31", money: "Rs. 1000"),
    CartItem(image: UIImage(named: "Design1")!, name: "The Raging Wolf", color: "Color : Grey", type: "95% Polyester, 5% Elastane", size: "Size : M", rank: "Leaderboard Rank : 43", money: "Rs. 1500")
    
]



var myOrders : [MyOrder] = [
    MyOrder(image: UIImage(named: "Design5")!, name: "King Pride", date: "Sep 14, 2024 - 10:42 AM", status: "On The Way", money: "Rs. 1000"),
    MyOrder(image: UIImage(named: "Design3")!, name: "The Raging Wolf", date: "Sep 14, 2024 - 10:42 AM", status: "Delivered", money: "Rs. 1000"),
    MyOrder(image: UIImage(named: "Design6")!, name: "King Pride", date: "Sep 14, 2024 - 10:42 AM", status: "Canceled", money: "Rs. 1000"),
    
    
    ]



var profileCell1 : [ProfileCell1] = [
    ProfileCell1(name1: "Victoria", username1: "@vicToria")
    ]



//var profileCells: [ProfileCell] = [
//    ProfileCell(
//        uid: "1",
//        userId: "1001",
//        username: "Victoria",
//        email: "victoria@example.com",
//        profileImageUrl: "https://example.com/images/victoria.jpg",
//        location: "Mumbai, India",
//        link: "https://victoria.com"
//    ),
//    ]




let yours : [Your] = [
    Your(title: "Your Friends")
    ]



let friends : [Friend] = [
    Friend(image: UIImage(named: "Design6")!, name: "Josephine", designs: "20 Designs"),
    Friend(image: UIImage(named: "Design5")!, name: "Rose", designs: "20 Designs"),
    Friend(image: UIImage(named: "Design4")!, name: "Elsa", designs: "20 Designs"),
    Friend(image: UIImage(named: "Design3")!, name: "Habid", designs: "20 Designs"),
    Friend(image: UIImage(named: "Design2")!, name: "John", designs: "20 Designs")
]
    


let designs : [Design] = [
    Design(title: "TheBlaze", imageName: UIImage(named: "Design2")!),
    Design(title: "Exaclibur", imageName: UIImage(named: "Design3")!),
    Design(title: "Dizy Blue", imageName: UIImage(named: "Design4")!)
    
    ]



let posts : [Post] = [
    Post(profileImage: UIImage(named: "profile4")!, name: "Warren Buffet shared a post.", time: "56 mins ago", desc: "Pirates on the go design inspired from the pirates of the caribbean.", hashtag: "#poc #pirates #cool", postImage: UIImage(named: "Design4")!)
]






class Datamodel {
    
    
    
    static var sampleUsers: [User] = [
        User(username: "sarah2201", profileImageName: UIImage(named: "profile4")!, makepostLabel: "Make a post"),
       ]
    
    
    static var sampleDesigns = [
        TShirtDesign(id: "1", title: "The Raging Wolf", creatorUsername: "@sarah2201", price: 700, imageName:"Design1", isFavorited: false, description: nil),
        TShirtDesign(id: "2", title: "The Breathing Forest", creatorUsername: "@itzmevic", price: 650, imageName: "Design2", isFavorited: true, description: nil),
        TShirtDesign(id: "3", title: "Space Splash", creatorUsername: "@artlover", price: 800, imageName: "Design3", isFavorited: false, description: nil),
        TShirtDesign(id: "4", title: "Abstract Waves", creatorUsername: "@waveartist", price: 750, imageName: "Design4", isFavorited: true, description: nil),
        TShirtDesign(id: "1", title: "The Raging Wolf", creatorUsername: "@sarah2201", price: 700, imageName:"Design5", isFavorited: false, description: nil),
        TShirtDesign(id: "2", title: "The Breathing Forest", creatorUsername: "@itzmevic", price: 650, imageName: "Design6", isFavorited: true, description: nil),
        TShirtDesign(id: "3", title: "Space Splash", creatorUsername: "@artlover", price: 800, imageName: "Design1", isFavorited: false, description: nil),
        TShirtDesign(id: "4", title: "Abstract Waves", creatorUsername: "@waveartist", price: 750, imageName: "Design2", isFavorited: true, description: nil)
    ]
    
    
    
    static var allUsers = [
           LeaderboardUser(name: "Alice", image: UIImage(named: "profile4")!, likes: 400),
           LeaderboardUser(name: "Bob", image: UIImage(named: "profile3")!, likes: 10),
           LeaderboardUser(name: "Charlie", image: UIImage(named: "profile7")!, likes: 110),
           LeaderboardUser(name: "Dave", image: UIImage(named: "profile5")!, likes: 75)
       ]

       // LeaderboardEntry initialized with default rankings
       static var leaderboardEntry: LeaderboardEntry = {
           var entry = LeaderboardEntry(
               firstUser: allUsers[0],
               secondUser: allUsers[1],
               thirdUser: allUsers[2]
           )
           entry.updateRanking(with: allUsers)
           return entry
       }()

    
    static var leaderboard: [Leaderboard] = [
        Leaderboard(
                    rank: 1,
                    username: "Dylan Harper",
                    profileImage:UIImage(named: "profile1") ?? UIImage(systemName: "person.circle"),
                    likes: 500,
                    designImage: "design4",
                    bio: "Award-winning designer with a passion for creativity.",
                    title: "Top Innovator"
                ),
                Leaderboard(
                    rank: 2,
                    username: "Ella Brown",
                    profileImage: UIImage(named: "profile2") ?? UIImage(systemName: "person.circle"),
                    likes: 450,
                    designImage: "design5",
                    bio: "Creating art from the heart. #DesignLove",
                    title: "Creative Leader"
                ),
                Leaderboard(
                    rank: 3,
                    username: "Frank White",
                    profileImage: UIImage(named: "profile4") ?? UIImage(systemName: "person.circle"),
                    likes: 400,
                    designImage: "design6",
                    bio: "UI/UX Designer | Innovating every day.",
                    title: "UI/UX Star"
                ),
    ]
    static var designers: [Designer] = [
        Designer(
            id: "1",
            name: "Jay Robe",
            profileImageName: "profile9",
            isContactable: true,
            bio: "Creative visionary with a passion for modern aesthetics.",
            postcount: 42,
            followcount: 1050,
            followingcount: 320
        ),
        Designer(
            id: "2",
            name: "Ellie Pierc",
            profileImageName: "profile8",
            isContactable: true,
            bio: "Crafting unique designs to inspire the world.",
            postcount: 58,
            followcount: 870,
            followingcount: 210
        ),
        Designer(
            id: "3",
            name: "Rick K",
            profileImageName: "profile6",
            isContactable: true,
            bio: "Transforming ideas into timeless designs.",
            postcount: 36,
            followcount: 650,
            followingcount: 180
        ),
        Designer(
            id: "4",
            name: "Zara S",
            profileImageName: "profile5",
            isContactable: true,
            bio: "Fashion-forward thinker with a flair for minimalism.",
            postcount: 48,
            followcount: 920,
            followingcount: 310
        )
    ]

    static var connectPeopleData: [ConnectPeople] = [
        ConnectPeople(id: "1", name: "Jay Robe", profileImageName: "profile6"),
        ConnectPeople(id: "2", name: "Ellie Pierc", profileImageName: "profile2"),
        ConnectPeople(id: "3", name: "Rick K", profileImageName: "profile1"),
        ConnectPeople(id: "4", name: "Zara S", profileImageName: "profile3"),
        ConnectPeople(id: "5", name: "Alex T", profileImageName: "profile4")
    ]


        
}
