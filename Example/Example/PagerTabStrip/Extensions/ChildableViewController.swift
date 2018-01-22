//
//  ChildableViewController.swift
//  Spartak Moscow FC
//
//  Created by Максим Смирнов on 13/11/2017.
//  Copyright © 2017 Finch. All rights reserved.
//

import UIKit

protocol ChildableViewController {
    
    var childNavigationItem: UINavigationItem { get }
    
}

extension ChildableViewController where Self: UIViewController {
    
    var childNavigationItem: UINavigationItem {
        
        guard let parent = parent else {
            return navigationItem
        }
        
        guard !(parent is UINavigationController) else {
            return navigationItem
        }
        
        return parent.navigationItem
    }
    
}
