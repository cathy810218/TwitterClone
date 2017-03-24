//
//  DetailViewController.swift
//  TwitterClone
//
//  Created by Cathy Oun on 3/21/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var tweet: Tweet!
    
    @IBOutlet weak var retweetedLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        retweetedLabel.text = tweet.isRetweeted ? "Retweeted" : "Non-retweeted"
        tweetLabel.text = tweet.text
        usernameLabel.text = tweet.user?.name == "" ? "Unknown" : tweet.user?.name
    }
}
