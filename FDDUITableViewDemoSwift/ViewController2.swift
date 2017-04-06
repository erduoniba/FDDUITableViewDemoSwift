//
//  ViewController2.swift
//  FDDUITableViewDemoSwift
//
//  Created by denglibing on 2017/2/23.
//  Copyright © 2017年 denglibing. All rights reserved.
//

import UIKit

/// 使用重载方式统一处理 UITableViewDataSource和UITableViewDelegate， 特殊的方法使用重载模式处理
class ViewController2: FDDBaseTableViewController, UITableViewDelegate, UITableViewDataSource {

    deinit {
        print(NSStringFromClass(ViewController2.self) + " dealloc")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "ViewController2"

        self.disposeDataSources()
        self.disposeTableViewConverter()
    }

    func disposeDataSources () {
        let randomSources = ["Swift is now open source!",
                             "We are excited by this new chapter in the story of Swift. After Apple unveiled the Swift programming language",
                             "For students, learning Swift has been a great introduction to modern programming concepts and best practices",
                             "Welcome to the Swift community. Together we are working to build a better programming language for everyone.",
                             "– The Swift Team"]

        for _ in 0...30 {
            let randomIndex: Int = Int(arc4random() % 5)
            let cellData: String = randomSources[randomIndex]
            let cellHeight: Float = HDTableViewCell.cellHeight(cellData as AnyObject?, boundWidth: Float(self.view.frame.size.width))
            let cellModel = FDDBaseCellModel.modelWithCellClass(HDTableViewCell.self,
                                                                cellHeight: cellHeight,
                                                                cellData: cellData as AnyObject?)
            self.dataArr.add(cellModel)
        }
    }

    func disposeTableViewConverter() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel: FDDBaseCellModel = (self.dataArr.object(at: indexPath.row) as? FDDBaseCellModel)!
        let cell: FDDBaseTableViewCell = tableView.cellForIndexPath(indexPath, cellClass: cellModel.cellClass)!
        cell.setCellData(cellModel.cellData, delegate: self)
        cell.setSeperatorAtIndexPath(indexPath, numberOfRowsInSection: 5)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(ViewController(tableViewStyle: .plain), animated: true)
    }
}
