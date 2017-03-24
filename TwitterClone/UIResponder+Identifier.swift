//
//  UIResponder+Identifier.swift
//  TwitterClone
//
//  Created by Cathy Oun on 3/23/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

import UIKit

extension UIResponder {
    static var identifier : String {
        return String(describing: self)
    }
}
