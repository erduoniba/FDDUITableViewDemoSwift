//
//  FDDTableViewConverter.swift
//  FDDUITableViewDemoSwift
//
//  Created by denglibing on 2017/2/10.
//  Copyright © 2017年 denglibing. All rights reserved.
//

import UIKit



extension FDDBaseViewController: FDDBaseTableViewCellDelegate {
    
    
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
    internal func fddTableViewCell(cell: FDDBaseTableViewCell, object: AnyObject?) {
        if cell.isMember(of: HDTableViewCell.self) {
            print("HDTableViewCell的代理")
        }
    }
}


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
