//
//  ImageTitleCellPagerModel.swift
//  testProject
//
//  Created by Максим Смирнов on 17/10/2017.
//  Copyright © 2017 Smirnov Maxim. All rights reserved.
//

import UIKit

class ImageTitleCellPagerModel {
    
    let cellModels: [Any]
    let selectedCellModels: [Any]
    
    private var models: [ImageTitleCell.Model] {
        return cellModels as? [ImageTitleCell.Model] ?? []
    }
    
    private var selectedModels: [ImageTitleCell.Model] {
        return selectedCellModels as? [ImageTitleCell.Model] ?? []
    }
    
    private var cellWidth: CGFloat = {
       return 60.0
    }()
    
    //MARK: - Init
    
    init(cellModels: [Any], selectedCellModels: [Any]) {
        
        self.cellModels = cellModels
        self.selectedCellModels = selectedCellModels
        
        calculateWidth()
        
    }
    
    //MARK: - Methods
    
    private func calculateWidth() {
        
        let width: [CGFloat] = models.map { $0.text.widthOfString(usingFont: $0.font) }
        let selectedWidth: [CGFloat] = selectedModels.map { $0.text.widthOfString(usingFont: $0.font) }
        
        cellWidth = [width, selectedWidth].flatMap{ $0 }.max() ?? 60.0
        
    }
    
}

//MARK: - PagerControlViewCellModel
extension ImageTitleCellPagerModel: PagerControlViewCellModel {
    
    func width(forIndex index: Int) -> CGFloat {
        return cellWidth
    }
    
    func selectedWidth(forIndex index: Int) -> CGFloat {
        return cellWidth
    }
    
}
