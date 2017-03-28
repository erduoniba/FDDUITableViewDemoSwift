//
//  ViewController.swift
//  FDDUITableViewDemoSwift
//
//  Created by denglibing on 2017/2/7.
//  Copyright © 2017年 denglibing. All rights reserved.
//

import UIKit

/// 使用注册方式统一处理 UITableViewDataSource和UITableViewDelegate， 特殊的方法使用注册模式处理
class ViewController: FDDBaseTableViewController {
    
    deinit {
        print(NSStringFromClass(ViewController.self) + " dealloc")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "ViewController";
        
        self.disposeDataSources()
        self.disposeTableViewConverter()
        
        self.addRefresgView(at: .top)
        self.addRefresgView(at: .bottom)
    }
    
    func disposeDataSources () {
        let randomSources = ["Swift is now open source!",
                             "We are excited by this new chapter in the story of Swift. After Apple unveiled the Swift programming language, it quickly became one of the fastest growing languages in history. Swift makes it easy to write software that is incredibly fast and safe by design. Now that Swift is open source, you can help make the best general purpose programming language available everywhere",
                             "For students, learning Swift has been a great introduction to modern programming concepts and best practices. And because it is now open, their Swift skills will be able to be applied to an even broader range of platforms, from mobile devices to the desktop to the cloud.",
                             "Welcome to the Swift community. Together we are working to build a better programming language for everyone.",
                             "– The Swift Team"]
        
        for _ in 0...6 {
            let randomIndex: Int = Int(arc4random() % 5)
            let cellData: String = randomSources[randomIndex]
            let cellModel = FDDBaseCellModel.modelWithCellClass(HDTableViewCell.self, cellHeight: HDTableViewCell.cellHeight(cellData as AnyObject?, boundWidth: Float(self.view.frame.size.width)), cellData: cellData as AnyObject?)
            self.dataArr.add(cellModel)
        }
    }
    
    
    func disposeTableViewConverter() {
        self.tableViewConverter.dataArr = self.dataArr
        
        self.tableViewConverter?.registerTableViewMethod(selector: #selector(UITableViewDelegate.tableView(_:didSelectRowAt:)), handleParams: { [weak self]  (params: Array) -> AnyObject? in
            withExtendedLifetime(self){
                self?.navigationController?.pushViewController(ViewController2(), animated: true)
                }!
            return nil
        })
        
        self.tableViewConverter?.registerTableViewMethod(selector: #selector(UITableViewDataSource.tableView(_:cellForRowAt:)), handleParams: { [weak self] (params : Array) -> AnyObject? in
            return withExtendedLifetime(self){ () -> FDDBaseTableViewCell in
                let tableView: UITableView = params[0] as! UITableView
                let indexPath: IndexPath = params[1] as! IndexPath
                let cellModel: FDDBaseCellModel = self?.dataArr.object(at: indexPath.row) as! FDDBaseCellModel
                let cell: FDDBaseTableViewCell = tableView.cellForIndexPath(indexPath, cellClass: cellModel.cellClass)!
                cell.setCellData(cellModel.cellData, delegate: self)
                cell.setSeperatorAtIndexPath(indexPath, numberOfRowsInSection: (self?.dataArr.count)!)
                return cell
            }
        })
        
        self.tableViewConverter?.registerTableViewMethod(selector: #selector(UITableViewDelegate.tableView(_:heightForRowAt:)), handleParams: { [weak self] (params: Array) -> AnyObject? in
            let height = withExtendedLifetime(self){ () -> CGFloat in
                let indexPath: IndexPath = params[1] as! IndexPath
                let cellModel: FDDBaseCellModel = self?.dataArr.object(at: indexPath.row) as! FDDBaseCellModel
                return CGFloat(cellModel.cellHeight)
            }
            
            return height as AnyObject?
        })
    }
    
    override func requestData() {
        let delayTime = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            if self.pageIndex == 0 {
                self.dataArr.removeAllObjects()
                self.disposeDataSources()
                self.tableView.reloadData()
                self.endRefreshing(at: .top)
                self.addRefresgView(at: .bottom)
            }
            else {
                self.disposeDataSources()
                self.tableView.reloadData()
                self.endRefreshing(at: .bottom)

                if self.dataArr.count > 25 {
                    self.hideRefreshView(at: .bottom)
                }
            }
        }
    }
    
    override internal func fddTableViewCell(cell: FDDBaseTableViewCell, object: AnyObject?) {
        print("xxx")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

