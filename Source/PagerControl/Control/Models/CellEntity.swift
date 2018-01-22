//
//  CellEntity.swift
//  testProject
//
//  Created by Smirnov Maxim on 16/10/2017.
//  Copyright © 2017 Smirnov Maxim. All rights reserved.
//

import Foundation

struct CellEntity {
    
    let isNib: Bool
    let reuseIdentifier: String
    let classType: AnyClass?
    let nibName: String?
    
    init(isNib: Bool, reuseIdentifier: String, nibName: String) {
        
        self.isNib = isNib
        self.reuseIdentifier = reuseIdentifier
        self.nibName = nibName
        self.classType = nil
        
    }
    
    init(isNib: Bool, reuseIdentifier: String, classType: AnyClass) {
        
        self.isNib = isNib
        self.reuseIdentifier = reuseIdentifier
        self.classType = classType
        self.nibName = nil
        
    }
    
}
