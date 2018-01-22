//
//  SpartakStripePagerView.swift
//  Spartak Moscow FC
//
//  Created by Smirnov Maxim on 26/10/2017.
//  Copyright © 2017 Smirnov Maxim. All rights reserved.
//

import UIKit

open class SpartakStripePagerView: UIView {
    
    //MARK: - Appearance
    
    public static let height: CGFloat = 52.0
    
    private struct Appearance {
        
        // MARK: - text
        let font: UIFont
        let selectedFont: UIFont
        let textColor: UIColor
        let selectedTextColor: UIColor
        
        // MARK: - line
        let lineHeight: CGFloat
        let lineColor: UIColor
        
        init() {
            
            font = UIFont.systemFont(ofSize: 16.0)
            selectedFont = UIFont.mediumSystemFont(ofSize: 16.0)
            textColor = #colorLiteral(red: 0.4159612656, green: 0.4159716368, blue: 0.4159660935, alpha: 1)
            selectedTextColor = .black
            lineHeight = 3.0
            lineColor = #colorLiteral(red: 0.6705882353, green: 0.07450980392, blue: 0.1803921569, alpha: 1)
            
        }
        
    }
    
    //MARK: - Init
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        drawSelf()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        drawSelf()
    }
    
    private func drawSelf() {
        
        addSubview(pagerControl)
        pagerControl.autoPinEdgesToSuperviewEdges()
        
    }
    
    //MARK: - Properies
    
    private let pagerControl = PagerControlView()
    
    private let entity: CellEntity = {
        return CellEntity(isNib: false, reuseIdentifier: StripeCell.className, classType: StripeCell.self)
    }()
    
    //MARK: - Interface
    
    public var selectedItem: Int {
        return pagerControl.selectedItem
    }
    
    public weak var delegate: PagerControlViewDelegate? {
        
        didSet {
            pagerControl.delegate = delegate
        }
        
    }
    
    public func selectItem(_ index: Int) {
        pagerControl.selectItem(index)
    }
    
    public func setup(withTabTitles titles: [String]) {
        
        var cellModels: [StripeCell.Model] = []
        var selectedCellModels: [StripeCell.Model] = []
        let appearance = Appearance()
        
        titles.forEach {
            cellModels.append(StripeCell.Model(textColor: appearance.textColor, font: appearance.font, text: $0))
            selectedCellModels.append(StripeCell.Model(textColor: appearance.selectedTextColor, font: appearance.selectedFont, text: $0))
        }
        
        let screenWidth = UIScreen.main.bounds.width
        let superFrame: CGRect = (frame == .zero) ? CGRect(origin: .zero, size: CGSize(width: screenWidth - 16.0, height: SpartakStripePagerView.height)) : frame
        let pagerCellModel = StripeCellPagerModel(cellModels: cellModels, selectedCellModels: selectedCellModels, superViewFrame: superFrame)
        
        let lineModel = PagerControlLineDealerModel(height: appearance.lineHeight, color: appearance.lineColor)
        let pagerModel = PagerControlViewModel(cellModel: pagerCellModel, lineModel: lineModel, cellEntity: entity)
        
        pagerControl.setup(withModel: pagerModel)
        
    }
    
}
