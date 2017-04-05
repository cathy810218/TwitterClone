//
//  User.swift
//  TwitterClone
//
//  Created by Cathy Oun on 3/21/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

import UIKit

class User {
    let name: String
    let screenName: String
    let profileImageURL : String
    let location: String
    var followerCount: String?
    var followingCount: String?
    
    init?(json: [String: Any]) {
        if let name = json["name"] as? String,
            let screenName = json["screen_name"] as? String,
            let profileImageURL = json["profile_image_url"] as? String,
            let location = json["location"] as? String{
            self.name = name
            self.screenName = screenName
            self.profileImageURL = profileImageURL
            self.location = location
            if let followerCount = json["followers_count"] as? Int,
                let followingCount = json["friends_count"] as? Int {
                self.followerCount = String(followerCount)
                self.followingCount = String(followingCount)
            }
        } else {
            return nil
        }
    }
    

}
