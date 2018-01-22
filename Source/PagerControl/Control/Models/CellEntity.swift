//
//  CellEntity.swift
//  testProject
//
//  Created by Smirnov Maxim on 16/10/2017.
//  Copyright © 2017 Smirnov Maxim. All rights reserved.
//

import Foundation

public struct CellEntity {
    
    public let isNib: Bool
    public let reuseIdentifier: String
    public let classType: AnyClass?
    public let nibName: String?
    
    public init(isNib: Bool, reuseIdentifier: String, nibName: String) {
        
        self.isNib = isNib
        self.reuseIdentifier = reuseIdentifier
        self.nibName = nibName
        self.classType = nil
        
    }
    
    public init(isNib: Bool, reuseIdentifier: String, classType: AnyClass) {
        
        self.isNib = isNib
        self.reuseIdentifier = reuseIdentifier
        self.classType = classType
        self.nibName = nil
        
    }
    
}
