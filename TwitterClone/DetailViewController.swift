//
//  DetailViewController.swift
//  TwitterClone
//
//  Created by Cathy Oun on 3/21/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {


    @IBOutlet weak var retweetedLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    var tweet: Tweet!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == TimelineViewController.identifier {
            guard let destinationVC = segue.destination as? TimelineViewController else {
                return
            }
            destinationVC.currentUser = tweet.user
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retweetedLabel.text = tweet.isRetweeted ? "Retweeted" : "Non-retweeted"
        tweetLabel.text = tweet.text
        usernameLabel.text = tweet.user?.name == "" ? "Unknown" : tweet.user?.name
        UIImage.fetchImageWith((tweet.user?.profileImageURL)!) { (image) in
            self.userImageView.image = image
        }

    }
}
