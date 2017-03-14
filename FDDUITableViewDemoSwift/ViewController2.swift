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

        self.title = "ViewController2";
        
        self.disposeDataSources()
        self.disposeTableViewConverter()
    }
    
    func disposeDataSources () {
        let randomSources = ["Swift is now open source!",
                             "We are excited by this new chapter in the story of Swift. After Apple unveiled the Swift programming language, it quickly became one of the fastest growing languages in history. Swift makes it easy to write software that is incredibly fast and safe by design. Now that Swift is open source, you can help make the best general purpose programming language available everywhere",
                             "For students, learning Swift has been a great introduction to modern programming concepts and best practices. And because it is now open, their Swift skills will be able to be applied to an even broader range of platforms, from mobile devices to the desktop to the cloud.",
                             "Welcome to the Swift community. Together we are working to build a better programming language for everyone.",
                             "– The Swift Team"]
        
        for _ in 0...30 {
            let randomIndex: Int = Int(arc4random() % 5)
            let cellData: String = randomSources[randomIndex]
            let cellModel = FDDBaseCellModel.modelWithCellClass(HDTableViewCell.self, cellHeight: HDTableViewCell.cellHeight(cellData as AnyObject?, boundWidth: Float(self.view.frame.size.width)), cellData: cellData as AnyObject?)
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
        let cellModel: FDDBaseCellModel = self.dataArr.object(at: indexPath.row) as! FDDBaseCellModel
        let cell: FDDBaseTableViewCell = tableView.cellForIndexPath(indexPath, cellClass: cellModel.cellClass)!
        cell.setCellData(cellModel.cellData, delegate: self)
        cell.setSeperatorAtIndexPath(indexPath, numberOfRowsInSection: 5)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(ViewController(tableViewStyle: .plain), animated: true)
    }


}
