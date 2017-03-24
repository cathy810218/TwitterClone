//
//  TwitterService.swift
//  TwitterClone
//
//  Created by Cathy Oun on 3/21/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

import UIKit
import Accounts
import Social

class TwitterService: NSObject {
    static let shared = TwitterService() // Singleton
    
    var account: ACAccount?
    
    private func login(completionHandler: @escaping (String?, ACAccount?) -> Void) {
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccounts(with: accountType, options: nil) { (granted, error) in
            if error != nil {
                completionHandler("Please sign in ", nil)
                return
            }
            
            if granted {
                if let account = accountStore.accounts(with: accountType).first as? ACAccount {
                    completionHandler(nil, account)
                }
            } else {
                completionHandler("This app requires Twitter access",nil)
                print("no access")
            }
        }
    }
    
    // Get Twitter account with the OAuth - validating with Twitter
    func getOAuthUser(callback: @escaping (String?, User?) -> Void) {
        let url = URL(string: "https://api.twitter.com/1.1/account/verify_credentials.json")
        
        if let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, url: url, parameters: nil) {
            
            request.account = self.account
            
            request.perform(handler: { (data, response, error) in
                if let error = error {
                    callback("Error: \(error.localizedDescription)",nil)
                    return
                }
                
                guard let response = response else { callback("no response",nil); return }
                guard let data = data else { callback("no data",nil); return }
                
                switch response.statusCode {
                case 200...299:
                    let user = TweetJSONParser.userFrom(data: data)
                    callback(nil, user)
                    break
                case 304:
                    callback("No new data",nil)
                    break
                case 400...499:
                    callback("Error: clients error", nil)
                    break
                case 500...599:
                    callback("Error: servers error", nil)
                    break
                default:
                    callback("unknow error with error code: \(response.statusCode)", nil)
                }
            })
        }
    }
    
    
    func updateTimeline(callback: @escaping (String?, [Tweet]?) -> (Void)) {
        let homeTimelneURL = URL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, url: homeTimelneURL, parameters: nil)
        request?.account = self.account
        
        request?.perform(handler: { (data, response, error) in
            if let error = error {
                callback("Error: \(error.localizedDescription)",nil)
            } else {
                guard let response = response else { callback("no response", nil); return }
                guard let data = data else { callback("no data", nil); return }
                
                switch response.statusCode {
                case 200:
                    // succeed!
                    TweetJSONParser.tweetsFrom(data: data, callback: { (success, tweets) in
                        callback(nil, tweets)
                    })
                    break
                case 304:
                    callback("No new data", nil)
                    break
                case 400...499:
                    callback("Error: clients error", nil)
                    break
                case 500...599:
                    callback("Error: server error", nil)
                    break
                default:
                    callback("unknown error", nil)
                    break
                }
            }
        })
    }
    
    func getTweets(callback: @escaping (String?, [Tweet]?) -> Void) {
        if self.account == nil {
            // not logged in yet
            login(completionHandler: { (errorMessage, account) in
                if let account = account {
                    self.account = account
                    self.updateTimeline(callback: callback)
                }
            })
        } else {
            self.updateTimeline(callback: callback)
        }
    }
}
