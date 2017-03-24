//
//  TweetTableViewCell.swift
//  TwitterClone
//
//  Created by Cathy Oun on 3/21/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {


    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var tweetSubtitleLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            //userProfileImageView.image = tweet?.user?.profileImage
            tweetLabel.text = tweet?.text
            if let user = tweet.user {
                tweetSubtitleLabel.text = user.name 
                UIImage.fetchImageWith(user.profileImageURL) { (image) in
                    self.userProfileImageView.image = image
                }
            }

        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
