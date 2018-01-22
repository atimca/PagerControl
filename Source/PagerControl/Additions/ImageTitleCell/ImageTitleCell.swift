//
//  ImageTitleCell.swift
//  testProject
//
//  Created by Максим Смирнов on 17/10/2017.
//  Copyright © 2017 Smirnov Maxim. All rights reserved.
//

import UIKit

open class ImageTitleCell: UICollectionViewCell {
    
    public static let height: CGFloat = 70.0
    
    // MARK: - Models
    
    public struct Model {
        
        public let textColor: UIColor
        public let font: UIFont
        public let text: String
        public let image: UIImage
        
        public init(textColor: UIColor = .black, font: UIFont = UIFont.systemFont(ofSize: 17.0), text: String, image: UIImage) {
            
            self.textColor = textColor
            self.font = font
            self.text = text
            self.image = image
            
        }
        
    }
    
    // MARK: - Properties
    
    private var textLabel: UILabel!
    private var imageView: UIImageView!
    
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
        
        label.textAlignment = .center
        label.autoPinEdgesToSuperviewEdges(excludingEdge: .top)
        
        let imageView = UIImageView()
        contentView.addSubview(imageView)
        
        imageView.autoSetDimension(.height, toSize: 40.0)
        imageView.contentMode = .scaleAspectFit
        imageView.autoPinEdgesToSuperviewEdges(excludingEdge: .bottom)
        
        self.textLabel = label
        self.imageView = imageView
        
    }
    
}

extension ImageTitleCell: Setupable {
    
    public func setup(_ object: Any) {
        
        guard let model = object as? Model else {
            return
        }
        
        UIView.animate(withDuration: 0.3) {
            
            self.imageView.image = model.image
            self.textLabel.textColor = model.textColor
            self.textLabel.text = model.text
            self.textLabel.font = model.font
            
        }
        
    }
    
}
