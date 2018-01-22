//
//  PagerTabStripModuleManager.swift
//  Spartak Moscow FC
//
//  Created by Smirnov Maxim on 31/08/2017.
//  Copyright © 2017 Finch. All rights reserved.
//

import UIKit

class PagerTabStripModuleManager {
    
    class func assembleModule(with parameters: [AnyHashable:Any]?) -> UIViewController {
        
        let presenter = PagerTabStripPresenter(viewControllers: parameters?["viewControllers"] as? [UIViewController],
                                               views: parameters?["views"] as? [UIView],
                                               tabNames: parameters?["tabNames"] as? [String])
        
        let view = PagerTabStripViewController()

        presenter.view = view
        
        view.presenter = presenter
        view.title = parameters?["title"] as? String
        
        return view
    }
    
}
