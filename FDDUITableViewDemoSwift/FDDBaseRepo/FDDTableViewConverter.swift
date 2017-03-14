//
//  FDDTableViewConverter.swift
//  FDDUITableViewDemoSwift
//
//  Created by denglibing on 2017/2/10.
//  Copyright © 2017年 denglibing. All rights reserved.
//

import UIKit

extension UITableView {
    func cellForIndexPath(_ indexPath: IndexPath, cellClass: AnyClass?) -> FDDBaseTableViewCell? {
        if (cellClass?.isSubclass(of: FDDBaseTableViewCell.self))! {
            let identifier = NSStringFromClass(cellClass!) + "ID"
            var cell = self.dequeueReusableCell(withIdentifier: identifier)
            if cell == nil {
                self.register(cellClass, forCellReuseIdentifier: identifier)
                cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
            }
            return cell as! FDDBaseTableViewCell?
        }
        return nil
    }
}


// 通过重载来实现特殊的cell
extension FDDBaseTableViewController: FDDBaseTableViewCellDelegate {
    
    @objc(tableView:numberOfRowsInSection:) func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    @objc(tableView:cellForRowAtIndexPath:) func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel: FDDBaseCellModel = self.dataArr.object(at: indexPath.row) as! FDDBaseCellModel
        let cell: FDDBaseTableViewCell = tableView.cellForIndexPath(indexPath, cellClass: cellModel.cellClass)!
        cell.setCellData(cellModel.cellData, delegate: self)
        cell.setSeperatorAtIndexPath(indexPath, numberOfRowsInSection: self.dataArr.count)
        return cell
    }
    
    @objc(tableView:heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellModel: FDDBaseCellModel = self.dataArr.object(at: indexPath.row) as! FDDBaseCellModel
        return CGFloat(cellModel.cellHeight)
    }
    
    // MARK: - FDDBaseTableViewCellDelegate
    public func fddTableViewCell(cell: FDDBaseTableViewCell, object: AnyObject?) {
        if cell.isMember(of: FDDBaseTableViewCell.self) {
            print("FDDBaseTableViewCell的代理")
        }
    }
}



typealias fddTableViewConterterBlock = (_ params: Array<Any>) -> AnyObject?

// 通过转换类来处理通用的tableView方法，特殊需要自己处理的使用 registerTableViewMethod 方式处理
public class FDDTableViewConverter: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    deinit {
        print(NSStringFromClass(FDDTableViewConverter.self) + " dealloc")
    }
    
    private var selectorBlocks = NSMutableDictionary()
    var dataArr = NSMutableArray()
    weak var tableViewCarrier: AnyObject?
    
    convenience public init(withTableViewCarrier tableViewCarrier: AnyObject, dataSources: NSMutableArray) {
        self.init()
        self.tableViewCarrier = tableViewCarrier
        self.dataArr = dataSources
    }
    
    open func registerTableViewMethod(selector: Selector, handleParams params: fddTableViewConterterBlock) {
        selectorBlocks.setObject(params, forKey: NSStringFromSelector(selector) as NSCopying)
    }
    
    private func converterFunction(_ function: String, params: Array<Any>) -> AnyObject? {
        
        let result: Bool = self.selectorBlocks.allKeys.contains { ele in
            if ele as! String == function {
                return true
            }
            else {
                return false
            }
        }
        
        if result {
            let block: fddTableViewConterterBlock = self.selectorBlocks.object(forKey: function) as! fddTableViewConterterBlock
            return block(params) as AnyObject?
        }
        
        return nil
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let selector = #selector(tableView(_:heightForRowAt:))
        let cellHeight = self.converterFunction(NSStringFromSelector(selector), params: [tableView, indexPath])
        if (cellHeight != nil)  {
            return cellHeight as! CGFloat
        }
        
        let cellModel: FDDBaseCellModel = self.dataArr.object(at: indexPath.row) as! FDDBaseCellModel
        return CGFloat(cellModel.cellHeight)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selector = #selector(tableView(_:cellForRowAt:))
        let closureCell = self.converterFunction(NSStringFromSelector(selector), params: [tableView, indexPath])
        if (closureCell != nil)  {
            return closureCell as! UITableViewCell
        }
        
        let cellModel: FDDBaseCellModel = self.dataArr.object(at: indexPath.row) as! FDDBaseCellModel
        let cell: FDDBaseTableViewCell = tableView.cellForIndexPath(indexPath, cellClass: cellModel.cellClass)!
        cell.setCellData(cellModel.cellData, delegate: self.tableViewCarrier as! FDDBaseTableViewCellDelegate?)
        cell.setSeperatorAtIndexPath(indexPath, numberOfRowsInSection: self.dataArr.count)
        return cell
    }
    
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selector = #selector(tableView(_:didSelectRowAt:))
        _ = self.converterFunction(NSStringFromSelector(selector), params: [tableView, indexPath])
    }
    
    
}
