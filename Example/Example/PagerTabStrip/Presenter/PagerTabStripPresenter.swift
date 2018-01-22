//
//  PagerTabStripPresenter.swift
//  Spartak Moscow FC
//
//  Created by Smirnov Maxim on 31/08/2017.
//  Copyright © 2017 Finch. All rights reserved.
//

import UIKit

class PagerTabStripPresenter {
    
    weak var view: PagerTabStripViewInput?
    
    private var viewControllers: [UIViewController]?
    private var views: [UIView]?
    private var tabNames: [String]?
    
    init(viewControllers: [UIViewController]? = nil, views: [UIView]? = nil, tabNames: [String]? = nil) {
        
        self.viewControllers = viewControllers
        self.views = views
        self.tabNames = tabNames
        
    }
    
}

extension PagerTabStripPresenter: PagerTabStripViewOutput {
    
    func viewIsReady() {
        
        guard let view = view else {
            return
        }
        
        if let controllers = viewControllers {
            controllers.forEach{ view.add(childViewController: $0) }
        } else if let views = views {
            views.forEach{ view.addChild(view: $0) }
        }
        
        if let data = tabNames {
            view.set(stripData: data)
        }
        
        viewControllers = nil
        views = nil
        
    }
    
}
