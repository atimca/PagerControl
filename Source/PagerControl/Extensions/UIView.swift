//
//  UIView.swift
//  PagerControl
//
//  Created by Maxim Smirnov on 22/01/2018.
//  Copyright © 2018 Maxim Smirnov. All rights reserved.
//

import UIKit

// I used to use awesome library PureLayout, nevertheless for this library I don't to use any external libraries. That's why I grab PureLayour api and made some funs for UIView.
extension UIView {
    
    enum Edge {
        
        case left
        case top
        case right
        case bottom
        
    }
    
    enum Dimension {
        
        case width
        case height
        
    }
    
    private func superviewConstraint(for edge: Edge) -> NSLayoutConstraint? {
        
        guard let superview = superview else {
            return nil
        }
        
        switch edge {
            
        case .left:
            return leftAnchor.constraint(equalTo: superview.leftAnchor)
            
        case .top:
            return topAnchor.constraint(equalTo: superview.topAnchor)
            
        case .right:
            return rightAnchor.constraint(equalTo: superview.rightAnchor)
            
        case .bottom:
            return bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            
        }
        
    }
    
    private var allEdges: [Edge] {
        return [.left, .top, .right, .bottom]
    }
    
    //MARK: - Public
    
    func autoPinEdgesToSuperviewEdges() {
        
        translatesAutoresizingMaskIntoConstraints = false
        allEdges.flatMap{ superviewConstraint(for: $0) }.forEach{ $0.isActive = true }
        
    }
    
    func autoPinEdgesToSuperviewEdges(excludingEdge: Edge) {
        
        translatesAutoresizingMaskIntoConstraints = false
        allEdges.filter{ $0 != excludingEdge }.flatMap{ superviewConstraint(for: $0) }.forEach{ $0.isActive = true }
        
    }
    
    func autoCenterInSuperview() {
        
        guard let superview = superview else {
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        
    }
    
    func autoSetDimension(_ dimension: Dimension, toSize size: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        switch dimension {
            
        case .height:
            heightAnchor.constraint(equalToConstant: size).isActive = true
            
        case .width:
            widthAnchor.constraint(equalToConstant: size).isActive = true
            
        }
        
    }
    
}
