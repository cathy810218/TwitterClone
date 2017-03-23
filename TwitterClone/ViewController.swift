//
//  ViewController.swift
//  TwitterClone
//
//  Created by Cathy Oun on 3/21/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var allTweets = [Tweet]()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        let tweetCellNib = UINib(nibName: "TweetTableViewCell", bundle: Bundle.main)
//        tableView.register(tweetCellNib, forCellReuseIdentifier: "TweetCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableViewAutomaticDimension

       refreshFeed()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "ShowDetailSegue" {
            // send curret cell's username to the next viewcontroller
            if let selectedIndex = self.tableView.indexPathForSelectedRow?.row {
                let selectedTweet = self.allTweets[selectedIndex]
                
                guard let destinationController = segue.destination as? DetailViewController else {
                    return
                }
                destinationController.tweet = selectedTweet
            }
        }
    }
    
    func refreshFeed() {
        TwitterService.shared.getTweets { (errorMessage, tweets) in
            if let tweets = tweets {
                OperationQueue.main.addOperation {
                    self.allTweets = tweets
                    self.tableView.reloadData()
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetTableViewCell
        cell.tweetLabel.text = self.allTweets[indexPath.row].text
        cell.tweetSubtitleLabel.text = self.allTweets[indexPath.row].user?.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
