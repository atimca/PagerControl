//
//  PagerControlViewCellModel.swift
//  testProject
//
//  Created by Smirnov Maxim on 16/10/2017.
//  Copyright © 2017 Smirnov Maxim. All rights reserved.
//

import UIKit

public protocol PagerControlViewCellModel {
    
    var cellModels: [Any] { get }
    var selectedCellModels: [Any] { get }
    var superViewFrame: CGRect { get }
    
    func width(forIndex index: Int) -> CGFloat
    func selectedWidth(forIndex index: Int) -> CGFloat
    
}

public extension PagerControlViewCellModel {
    
    var superViewFrame: CGRect {
        return .zero
    }
    
    var count: Int {
        
        guard cellModels.count == selectedCellModels.count else {
            assertionFailure("Models should have equal size")
            return 0
        }
        
        return cellModels.count
    }
    
}
