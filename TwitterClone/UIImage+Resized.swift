//
//  UIImage+Resized.swift
//  TwitterClone
//
//  Created by Cathy Oun on 3/23/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

import UIKit

extension UIImage {
    func resized(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        
        let newFrame = CGRect(x: 0.0,
                              y: 0.0,
                              width: size.width,
                              height: size.height)
        self.draw(in: newFrame)
        
        defer { // execute immediately after the return statment
            UIGraphicsEndImageContext()
        }
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
