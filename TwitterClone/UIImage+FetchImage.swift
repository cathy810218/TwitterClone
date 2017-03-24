//
//  UIImage+FetchImage.swift
//  TwitterClone
//
//  Created by Cathy Oun on 3/23/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func fetchImageWith(_ urlString: String, callback: @escaping (UIImage?) -> Void) {
        OperationQueue().addOperation {
            guard let url = URL(string: urlString) else {
                callback(nil)
                return
            }
            if let data = try? Data(contentsOf: url) {
                let image = UIImage(data: data)
                OperationQueue.main.addOperation {
                    callback(image)
                }
            } else {
                OperationQueue.main.addOperation {
                    callback(nil)
                }
            }
        }
    }
}
