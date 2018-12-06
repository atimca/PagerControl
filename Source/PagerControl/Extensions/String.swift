//
//  String.swift
//  PagerControl
//
//  Created by Maxim Smirnov on 22/01/2018.
//  Copyright © 2018 Maxim Smirnov. All rights reserved.
//

import UIKit

extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        let width: CGFloat = CGFloat(ceilf(Float(size.width)))
        
        return width
    }
    
}
