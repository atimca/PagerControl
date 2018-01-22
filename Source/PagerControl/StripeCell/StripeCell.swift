//
//  SMStripeCell.swift
//  testProject
//
//  Created by Smirnov Maxim on 27/04/2017.
//  Copyright © 2017 Smirnov Maxim. All rights reserved.
//

import UIKit

class StripeCell: UICollectionViewCell {
    
    // MARK: - Models
    
    struct Model {
        
        var textColor: UIColor
        var font: UIFont
        var text: String
        
        init(textColor: UIColor = .black, font: UIFont = UIFont.systemFont(ofSize: 17.0), text: String) {
            
            self.textColor = textColor
            self.font = font
            self.text = text
            
        }
        
    }
    
    // MARK: - Properties
    
    private var textLabel: UILabel?
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
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
    
    func setup(_ object: Any) {
        
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
