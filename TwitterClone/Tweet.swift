//
//  Tweet.swift
//  TwitterClone
//
//  Created by Cathy Oun on 3/21/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

import UIKit

class Tweet {
    let text : String
    let id : String
    
    var user : User? // Set as an optional because some tweets (most often "sponsored tweets" don't have an associated Twitter user account
    var isRetweeted : Bool = false
    
    init?(json: [String: Any]) { // Failable initializer
        if let text = json["text"] as? String, let id = json["id_str"] as? String { // chain together both optional unwrap
            self.text = text
            self.id = id
            if let userDictionary = json["user"] as? [String: Any]{
                self.user = User(json: userDictionary)
            }
            
            if let _ = json["retweeted_status"] as? [String : AnyObject] {
                self.isRetweeted = true
            }
        } else { // if both values cannot be cast as Strings, return a nil value
            return nil
        }
    }
}
