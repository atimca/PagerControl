//
//  StripeCellPagerModel.swift
//  testProject
//
//  Created by Smirnov Maxim on 16/10/2017.
//  Copyright © 2017 Smirnov Maxim. All rights reserved.
//

import UIKit

class StripeCellPagerModel {
    
    let cellModels: [Any]
    let selectedCellModels: [Any]
    let superViewFrame: CGRect
    
    private var models: [StripeCell.Model]? {
        return cellModels as? [StripeCell.Model]
    }
    
    private var selectedModels: [StripeCell.Model]? {
        return selectedCellModels as? [StripeCell.Model]
    }
    
    private var cellsWidth: [CGFloat] = []
    private var selectedCellsWidth: [CGFloat] = []
    
    //MARK: - Init
    
    init(cellModels: [Any], selectedCellModels: [Any], superViewFrame: CGRect) {
     
        self.cellModels = cellModels
        self.selectedCellModels = selectedCellModels
        self.superViewFrame = superViewFrame
        setupCellWidth()
        
    }

}

extension StripeCellPagerModel: PagerControlViewCellModel {
    
    func width(forIndex index: Int) -> CGFloat {
        return cellsWidth[safe: index] ?? 0.0
    }
    
    func selectedWidth(forIndex index: Int) -> CGFloat {
        return selectedCellsWidth[safe: index] ?? 0.0
    }
    
    //MARK: - Cell width
    
    private func setupCellWidth() {
        
        cellsWidth.removeAll()
        selectedCellsWidth.removeAll()
        
        guard let models = models, let selectedModels = selectedModels else {
            return
        }
        
        let inset: CGFloat = 16
        
        models.forEach {
            cellsWidth.append($0.text.widthOfString(usingFont: $0.font) + inset)
        }
        
        selectedModels.forEach {
            selectedCellsWidth.append($0.text.widthOfString(usingFont: $0.font) + inset)
        }
        
        checkWidthForFullness()
        
    }
    
    private func checkWidthForFullness() {
        
        let checkWidth = superViewFrame.width
        
        let summ = cellsWidth.reduce(0, +)
        let deltaSumm = checkWidth - summ
        
        let selectedSumm = selectedCellsWidth.reduce(0, +)
        let selectedDeltaSumm = checkWidth - selectedSumm
        
        if summ < checkWidth && selectedSumm < checkWidth, cellsWidth.count != 0 {
            
            let averageWidth = superViewFrame.width / CGFloat(cellsWidth.count)
            let maxWidth = [cellsWidth, selectedCellsWidth].flatMap{ $0 }.max() ?? 0
            
            if averageWidth > maxWidth {
                
                cellsWidth = cellsWidth.map{ _ in averageWidth}
                selectedCellsWidth = cellsWidth
                
                return
            }
            
            let isSummGreater = summ > selectedSumm
            let maxArray = isSummGreater  ? cellsWidth : selectedCellsWidth
            let deltaWidth = (isSummGreater ? deltaSumm : selectedDeltaSumm) / CGFloat(cellsWidth.count)
            
            cellsWidth = maxArray.map{ $0 + deltaWidth }
            selectedCellsWidth = cellsWidth
            
        }
        
    }
    
}
