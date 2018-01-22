//
//  PagerControlLiveDealer.swift
//  testProject
//
//  Created by Smirnov Maxim on 16/10/2017.
//  Copyright © 2017 Smirnov Maxim. All rights reserved.
//

import UIKit

protocol PagerControlLineDealer {
    
    func setupLine(withModel model: PagerControlLineDealerModel, andInitialWidth width: CGFloat)
    func updateLine(forFrame frame: CGRect)
    
}

struct PagerControlLineDealerModel {
    
    let height: CGFloat
    let color: UIColor
    
}

class PagerControlLineDealerImplementation {
    
    private var line: CALayer?
    private weak var superview: UIView?
    
    init(superview: UIView) {
        self.superview = superview
    }
    
}

extension PagerControlLineDealerImplementation: PagerControlLineDealer {
    
    func setupLine(withModel model: PagerControlLineDealerModel, andInitialWidth width: CGFloat) {
        
        self.line?.removeFromSuperlayer()
        
        guard let superview = superview else {
            return
        }
        
        let line = CALayer()
        line.frame = CGRect(origin: .init(x: 0.0, y: superview.frame.height - model.height),
                            size: .init(width: width, height: model.height))
        
        line.backgroundColor = model.color.cgColor
        
        superview.layer.addSublayer(line)
        
        self.line = line
        
    }
    
    func updateLine(forFrame frame: CGRect) {
        
        let x = (frame.minX + frame.maxX) / 2
        let width = frame.width
        
        line?.position.x = x
        line?.bounds.size.width = width
        
    }
    
}
