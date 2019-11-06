//
//  Collection.swift
//  PagerControl
//
//  Created by Maxim Smirnov on 22/01/2018.
//  Copyright © 2018 Maxim Smirnov. All rights reserved.
//

import Foundation

extension Collection {
    
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
