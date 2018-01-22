//
//  SMStripeCell.swift
//  testProject
//
//  Created by Smirnov Maxim on 27/04/2017.
//  Copyright © 2017 Smirnov Maxim. All rights reserved.
//

import UIKit

open class StripeCell: UICollectionViewCell {
    
    // MARK: - Models
    
    public struct Model {
        
        public var textColor: UIColor
        public var font: UIFont
        public var text: String
        
        public init(textColor: UIColor = .black, font: UIFont = UIFont.systemFont(ofSize: 17.0), text: String) {
            
            self.textColor = textColor
            self.font = font
            self.text = text
            
        }
        
    }
    
    // MARK: - Properties
    
    private var textLabel: UILabel?
    
    // MARK: - init
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        
        let label = UILabel()
        contentView.addSubview(label)
        
        label.autoCenterInSuperview()
        
        self.textLabel = label
        
    }
    
}

extension StripeCell: Setupable {
    
    public func setup(_ object: Any) {
        
        guard let model = object as? Model else {
            return
        }
        
        UIView.animate(withDuration: 0.3) {
            
            self.textLabel?.textColor = model.textColor
            self.textLabel?.text = model.text
            self.textLabel?.font = model.font
            
        }
        
    }
    
}
