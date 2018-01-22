//
//  NSObject.swift
//  PagerControl
//
//  Created by Maxim Smirnov on 22/01/2018.
//  Copyright © 2018 Maxim Smirnov. All rights reserved.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
