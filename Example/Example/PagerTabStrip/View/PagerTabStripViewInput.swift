//
//  PagerTabStripViewInput.swift
//  Spartak Moscow FC
//
//  Created by Maxim Smirnov on 08/11/2017.
//  Copyright © 2017 Finch. All rights reserved.
//

import UIKit

protocol PagerTabStripViewInput: class {
    
    func add(childViewController: UIViewController)
    func addChild(view: UIView)
    func set(stripData: [String])
    
}
