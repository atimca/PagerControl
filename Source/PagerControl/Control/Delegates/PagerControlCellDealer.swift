//
//  PagerControlCellDealer.swift
//  testProject
//
//  Created by Максим Смирнов on 17/10/2017.
//  Copyright © 2017 Smirnov Maxim. All rights reserved.
//

import UIKit

protocol PagerControlCellDealer {
    
    func registerCell(withEntity entity: CellEntity, forCollectionView collectionView: UICollectionView)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}

class PagerControllCellDealerImplementation: PagerControlCellDealer {
    
    private var entity: CellEntity?
    
    func registerCell(withEntity entity: CellEntity, forCollectionView collectionView: UICollectionView) {
        
        self.entity = entity
        
        let identifier = entity.reuseIdentifier
        
        if entity.isNib, let nibName = entity.nibName {
            
            collectionView.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: identifier)
            
        } else if let type = entity.classType {
            
            collectionView.register(type, forCellWithReuseIdentifier: identifier)
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let entity = entity else {
            return UICollectionViewCell()
        }
        
        return collectionView.dequeueReusableCell(withReuseIdentifier: entity.reuseIdentifier, for: indexPath)
    }
    
}
