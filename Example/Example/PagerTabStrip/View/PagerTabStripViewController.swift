//
//  PagerTabStripViewController.swift
//  testProject
//
//  Created by Smirnov Maxim on 30/08/2017.
//  Copyright © 2017 Finch. All rights reserved.
//

import UIKit
import PagerControl
import PureLayout

class PagerTabStripViewController: UIViewController {
    
    //MARK: - Properties
    
    private var stripPager: SpartakStripePagerView!
    private var scrollView: UIScrollView!
    private var childViews: [UIView] = []
    private var inManualScrolling: Bool = false
    private var slideView: UIView?
    
    var presenter: PagerTabStripViewOutput?
    
    //MARK: - LifeCircle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter?.viewIsReady()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard childViews.count != children.count else {
            return
        }
        
        children.forEach { addChild(view: $0.view) }
        
        let gestureLine = UIView()
        gestureLine.backgroundColor = .clear
        view.addSubview(gestureLine)
        gestureLine.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .right)
        gestureLine.autoSetDimension(.width, toSize: 10.0)
    
        slideView.map{ view.bringSubviewToFront($0) }
        
    }
    
    //MARK: - Setup
    
    func setup() {
        
        automaticallyAdjustsScrollViewInsets = false
        addStrip()
        addScrollView()
        
        view.backgroundColor = #colorLiteral(red: 0.9688121676, green: 0.9688346982, blue: 0.9688225389, alpha: 1)
        
        slideView?.removeFromSuperview()
        let slide = UIView()
        view.addSubview(slide)
        slide.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .right)
        slide.autoSetDimension(.width, toSize: 10.0)
        slideView = slide
        
    }
    
    //MARK: - Private
    
    private func addStrip() {
        
        let stripPager = SpartakStripePagerView()
        view.addSubview(stripPager)
        stripPager.autoPinEdgesToSuperviewEdges(with: .init(top: 16.0, left: 0, bottom: 0, right: 0), excludingEdge: .bottom)
        stripPager.autoSetDimension(.height, toSize: SpartakStripePagerView.height)
        stripPager.backgroundColor = .clear
        stripPager.delegate = self
        
        self.stripPager = stripPager
        
    }
    
    private func addScrollView() {
        
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = true
        scrollView.isPagingEnabled = true
        
        view.addSubview(scrollView)
        
        let tabViewHeight = tabBarController?.tabBar.frame.height ?? 0
        scrollView.autoPinEdgesToSuperviewEdges(with: .init(top: 0, left: 0, bottom: tabViewHeight, right: 0), excludingEdge: .top)
        scrollView.autoPinEdge(.top, to: .bottom, of: stripPager)
        
        scrollView.delegate = self
        
        self.scrollView = scrollView
        
    }
    
}

extension PagerTabStripViewController: PagerTabStripViewInput {
    
    func add(childViewController: UIViewController) {
        
        addChild(childViewController)
        childViewController.didMove(toParent: self)
        
    }
    
    func addChild(view: UIView) {
        
        let width = scrollView.frame.width
        let height = scrollView.frame.height
        let index = childViews.count
        
        view.frame = CGRect(x: width * CGFloat(index), y:0, width: width, height: height)
        scrollView.addSubview(view)
        
        childViews.append(view)
        
        scrollView.contentSize.height = height
        scrollView.contentSize.width = width * CGFloat(childViews.count)
        
    }
    
    func set(stripData: [String]) {
        stripPager.setup(withTabTitles: stripData)
    }
    
}

extension PagerTabStripViewController: PagerControlViewDelegate {
    
    func didSwitchToItem(withIndex index: Int) {
        
        view.endEditing(true)
        
        inManualScrolling = true
        var frame = scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(index)
        frame.origin.y = 0
        scrollView.scrollRectToVisible(frame, animated: true)
        
    }
    
}

extension PagerTabStripViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let page = scrollView.currentPage
        guard page != stripPager.selectedItem, !inManualScrolling else {
            return
        }
        
        stripPager.selectItem(page)
        
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        inManualScrolling = false
    }
    
}
