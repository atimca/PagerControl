//
//  PagerControlViewDelegate.swift
//  testProject
//
//  Created by Smirnov Maxim on 16/10/2017.
//  Copyright © 2017 Smirnov Maxim. All rights reserved.
//

import Foundation

protocol PagerControlViewDelegate: class {
    
    /// Optional
    func didSwitchToItem(withIndex index: Int)
    func didSwitchToItemAfterAnimation(withIndex index: Int)
    
}

extension PagerControlViewDelegate {
    func didSwitchToItem(withIndex index: Int) {}
    func didSwitchToItemAfterAnimation(withIndex index: Int) {}
}
