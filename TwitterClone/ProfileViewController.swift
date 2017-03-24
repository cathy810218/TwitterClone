//
//  ProfileViewController.swift
//  TwitterClone
//
//  Created by Cathy Oun on 3/23/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var user: User?
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = user {
            usernameLabel.text = user.name
            locationLabel.text = user.location == "" ? "Unknown" : user.location
            followerLabel.text = user.followerCount
            followingLabel.text = user.followingCount
        }
        displayUserImage()
    }
    
    func displayUserImage() {
        OperationQueue.main.addOperation {
            if let imageURLString = self.user?.profileImageURL
            {
                let imageString = imageURLString.replacingOccurrences(of: "_normal", with: "")
                let imageURL = URL(string: imageString)
                if let profileImage = try? UIImage(data: NSData(contentsOf: imageURL!) as Data) {
                    self.profileImageView.image = profileImage
                }
            }
        }
    }
}
