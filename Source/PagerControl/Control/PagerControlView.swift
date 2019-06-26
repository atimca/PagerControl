//
//  PagerControlView.swift
//  Spartak Moscow FC
//
//  Created by Smirnov Maxim on 16/10/2017.
//  Copyright © 2017 Smirnov Maxim. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

open class PagerControlView: UIView {
    
    // MARK: - Properties
    
    private let delegateEvents = PublishSubject<Event>()
    
    private var collectionView: UICollectionView!
    
    private(set) public var selectedItem: Int = 0
    open weak var delegate: PagerControlViewDelegate?
    
    private lazy var cellDealer: PagerControlCellDealer = {
        return PagerControllCellDealerImplementation()
    }()
    
    private var _lineDealer: PagerControlLineDealer?
    private var lineDealer: PagerControlLineDealer? {
        
        guard let dealer = _lineDealer else {
            
            guard viewModel?.lineModel != nil else {
                return nil
            }
            
            _lineDealer = PagerControlLineDealerImplementation(superview: collectionView)
            
            return _lineDealer
        }
        
        return dealer
    }
    
    // MARK: - Model Properties
    
    private var viewModel: PagerControlViewModel?
    
    // MARK: - LifeCircle
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        let cellFrame = collectionView?.cellForItem(at: IndexPath(row: selectedItem, section: 0))?.frame
        guard frame.width != 0.0, cellFrame == nil else {
            return
        }
        
        setupLine()
        
    }
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCollectionView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        
        self.collectionView?.removeFromSuperview()
        
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: flow)
        addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges()
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = .clear
        
        self.collectionView = collectionView
        
    }
    
    //MARK: - Public
    
    open func setup(withModel viewModel: PagerControlViewModel) {
        
        self.viewModel = viewModel
        setupLine()
        cellDealer.registerCell(withEntity: viewModel.cellEntity, forCollectionView: collectionView)
        collectionView?.reloadData()
        scroll(toIndex: 0, isForce: true)
        
    }
    
    open func selectItem(_ index: Int) {
        scroll(toIndex: index)
    }
    
    //MARK: - Private
    
    private func scroll(toIndex index: Int, isForce: Bool = false) {
        
        let previousIndexPath = IndexPath(item: selectedItem, section: 0)
        let previousIndex = selectedItem
        
        guard (previousIndex != index) || isForce else {
            return
        }
        
        selectedItem = index
        
        let scrollPosition: UICollectionView.ScrollPosition
        
        switch index {
            
        case collectionView.numberOfItems(inSection: 0) - 1:
            scrollPosition = .left
            
        case 0:
            scrollPosition = .right
            
        default:
            scrollPosition = .centeredHorizontally
            
        }
        
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: scrollPosition, animated: true)
        
        //TODO: - maybe batch update?
        setupCells(forCollectionView: collectionView, withIndexPaxes: [indexPath, previousIndexPath], animate: true)
        
        guard let frame = collectionView.cellForItem(at: indexPath)?.frame else {
            return
        }
        
        updateLine(forFrame: frame)
        
    }
    
    //MARK: - Line
    
    private func setupLine() {
        
        guard let model = viewModel?.lineModel, let width = viewModel?.cellModel.selectedWidth(forIndex: 0) else {
            return
        }
        
        lineDealer?.setupLine(withModel: model, andInitialWidth: width)
        
    }
    
    private func updateLine(forFrame frame: CGRect) {
        lineDealer?.updateLine(forFrame: frame)
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension PagerControlView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        scroll(toIndex: indexPath.item)
        
        delegate?.didSwitchToItem(withIndex: selectedItem)
        delegateEvents.onNext(.switchedToItem(index: selectedItem))
        //call delegate after animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.delegate?.didSwitchToItemAfterAnimation(withIndex: self.selectedItem)
            self.delegateEvents.onNext(.switchedToItemAfterAnimation(index: self.selectedItem))
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let viewModel = viewModel else {
            return .zero
        }
        
        let item = indexPath.item
        let isSelected = (item == selectedItem)
        let setupWidth = isSelected ? viewModel.cellModel.selectedWidth(forIndex: item) : viewModel.cellModel.width(forIndex: item)
        
        return CGSize(width: setupWidth, height: collectionView.frame.height)
    }
}

//MARK: - UICollectionViewDataSource
extension PagerControlView: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.cellModel.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = cellDealer.collectionView(collectionView, cellForItemAt: indexPath)
        
        if let cell = cell as? Setupable {
            setup(cell: cell, forIndexPath: indexPath)
        }
        
        return cell
    }
    
    private func setupCells(forCollectionView collectionView: UICollectionView, withIndexPaxes indexPaxes: [IndexPath], animate: Bool = false) {
        
        for indexPath in indexPaxes {
            
            guard let cell = collectionView.cellForItem(at: indexPath) as? Setupable else {
                continue
            }
            
            setup(cell: cell, forIndexPath: indexPath)
            
        }
        
    }
    
    private func setup(cell: Setupable, forIndexPath indexPath: IndexPath) {
        
        guard let cellModel = viewModel?.cellModel else {
            return
        }
        
        let item = indexPath.item
        let isSelected = (item == selectedItem)
        
        guard let setupModel = isSelected ? cellModel.selectedCellModels[safe: item] : cellModel.cellModels[safe: item] else {
            return
        }
        
        cell.setup(setupModel)
        
    }
    
}

// MARK: - Emitable
public extension PagerControlView {
    enum Event {
        case switchedToItem(index: Int)
        case switchedToItemAfterAnimation(index: Int)
    }
    
    var events: ControlEvent<Event> {
        return ControlEvent(events: delegateEvents)
    }
}

