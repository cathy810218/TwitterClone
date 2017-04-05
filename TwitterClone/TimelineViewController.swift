//
//  TimelineViewController.swift
//  TwitterClone
//
//  Created by Cathy Oun on 3/21/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var allTweets = [Tweet]()
    var currentUser: User?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tweetCellNib = UINib(nibName: "TweetTableViewCell", bundle: Bundle.main)
        tableView.register(tweetCellNib, forCellReuseIdentifier: TweetTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension

        refreshFeed()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch segue.identifier! {
        case DetailViewController.identifier:
            if let selectedIndex = self.tableView.indexPathForSelectedRow?.row {
                let selectedTweet = self.allTweets[selectedIndex]
                
                guard let destinationController = segue.destination as? DetailViewController else {
                    return
                }
                destinationController.tweet = selectedTweet
            }
            break
        case ProfileViewController.identifier:
            guard let destinationController = segue.destination as? ProfileViewController else {
                return
            }
            destinationController.user = currentUser
            break
        default:
            break
        }
    }
    
    func refreshFeed() {
        TwitterService.shared.getTweets { (errorMessage, tweets) in
            if let tweets = tweets {
                OperationQueue.main.addOperation {
                    self.allTweets = tweets
                    self.tableView.reloadData()
                }
                
                TwitterService.shared.getOAuthUser(callback: { (errorMsg, user) in
                    self.currentUser = user
                })
            }
        }
//        TwitterService.shared.getTweetsForUserWith((self.currentUser?.screenName)!) { (errorMessage, tweets) in
//            if let tweets = tweets {
//                self.allTweets = tweets
//                self.tableView.reloadData()
//            }
//        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as! TweetTableViewCell
        cell.tweet = self.allTweets[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.allTweets[indexPath.row]
        self.performSegue(withIdentifier: DetailViewController.identifier, sender: nil)
    }
}
