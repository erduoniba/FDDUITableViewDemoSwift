//
//  FDDBaseCellModel.swift
//  FDDUITableViewDemo
//
//  Created by denglibing on 2017/2/9.
//  Copyright © 2017年 denglibing. All rights reserved.
//

import UIKit

class FDDBaseCellModel: NSObject {
    var cellData:   AnyObject?
    var cellClass:  AnyClass?
    var delegate:   AnyObject?
    var cellHeight: Float = 44
    var staticCell: UITableViewCell?
    
    override init() {
        super.init()
    }
    
    convenience init(cellClass: AnyClass?, cellHeight: Float, cellData: AnyObject?) {
        self.init()
        self.cellClass = cellClass
        self.cellHeight = cellHeight
        self.cellData = cellData
    }

    class func modelWithCellClass(_ cellClass: AnyClass?, cellHeight: Float, cellData: AnyObject?) -> FDDBaseCellModel {
        let cellModel: FDDBaseCellModel = FDDBaseCellModel(cellClass: cellClass, cellHeight: cellHeight, cellData: cellData)
        return cellModel
    }
    

}
