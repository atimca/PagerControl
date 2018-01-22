//
//  UIScrollView.swift
//  Spartak Moscow FC
//
//  Created by Smirnov Maxim on 31/08/2017.
//  Copyright © 2018 Maxim Smirnov. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    var currentPage: Int {
        let pageWidth:CGFloat = frame.width
        let currentPage:CGFloat = floor((contentOffset.x - pageWidth / 2) / pageWidth) + 1
        return Int(currentPage)
    }
    
}
