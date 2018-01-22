//
//  ViewController.swift
//  Example
//
//  Created by Maxim Smirnov on 22/01/2018.
//  Copyright © 2018 Maxim Smirnov. All rights reserved.
//

import UIKit
import PureLayout
import PagerControl

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let titles: [String] = ["11111111", "222222222", "33333333", "44444444", "55555555", "66666666", "77777777", "88888888"]
        let images: [UIImage] = [#imageLiteral(resourceName: "2"), #imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "8"), #imageLiteral(resourceName: "6"),#imageLiteral(resourceName: "3"), #imageLiteral(resourceName: "4"), #imageLiteral(resourceName: "7"), #imageLiteral(resourceName: "5")]
        
        let models: [ImageTitleCell.Model] = titles.enumerated().map{ ImageTitleCell.Model(text: $0.element, image: images[$0.offset]) }
        let selected: [ImageTitleCell.Model] = titles.enumerated().map{ ImageTitleCell.Model(textColor: .white, text: $0.element, image: images[$0.offset]) }
        
        let imagePages = PagerControlView()
        view.addSubview(imagePages)
        imagePages.autoCenterInSuperview()
        imagePages.autoPinEdge(toSuperviewEdge: .left)
        imagePages.autoPinEdge(toSuperviewEdge: .right)
        imagePages.autoSetDimension(.height, toSize: ImageTitleCell.height)

        let pagerCellModel = ImageTitleCellPagerModel(cellModels: models, selectedCellModels: selected)
        let entity = CellEntity(isNib: false, reuseIdentifier: ImageTitleCell.className, classType: ImageTitleCell.self)
        
        let pagerModel = PagerControlViewModel(cellModel: pagerCellModel, cellEntity: entity)
        
        imagePages.setup(withModel: pagerModel)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

