//
//  TweetJSONParser.swift
//  TwitterClone
//
//  Created by Cathy Oun on 3/21/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

import UIKit

class TweetJSONParser: NSObject {
    
    class func userFrom(data: Data) -> User? {
        do {
            if let userJSON = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] {
                let loggedInUser = User(json: userJSON)
                return loggedInUser
            }
        } catch {
            print("Error serializing user JSON")
        }
        return nil
    }
    
    class func tweetsFrom(data: Data, callback: (_ success: Bool, _ tweets: [Tweet]?) -> Void) {
        do {
            if let rootObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String : Any]] {
                var tweets = [Tweet]()
                
                for tweetDictionary in rootObject {
                    if let tweet = Tweet(json: tweetDictionary) {
                        tweets.append(tweet)
                    }
                }
                callback(true, tweets)
            }
        } catch {
            print("Error serializing JSON")
            callback(false, nil)
        }
    }

}
