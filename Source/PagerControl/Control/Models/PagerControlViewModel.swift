//
//  PagerControlViewModel.swift
//  testProject
//
//  Created by Smirnov Maxim on 16/10/2017.
//  Copyright © 2017 Smirnov Maxim. All rights reserved.
//

import Foundation

public struct PagerControlViewModel {
    
    public let cellModel: PagerControlViewCellModel
    public var lineModel: PagerControlLineDealerModel?
    public let cellEntity: CellEntity
    
    public init(cellModel: PagerControlViewCellModel, lineModel: PagerControlLineDealerModel? = nil, cellEntity: CellEntity) {
        
        self.cellModel = cellModel
        self.lineModel = lineModel
        self.cellEntity = cellEntity
        
    }
    
}
