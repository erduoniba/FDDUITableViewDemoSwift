//
//  FDDBaseCellModel.swift
//  FDDUITableViewDemoSwift
//
//  Created by denglibing on 2017/2/9.
//  Copyright © 2017年 denglibing. All rights reserved.
//  Demo: https://github.com/erduoniba/FDDUITableViewDemoSwift
//

import UIKit

open class FDDBaseCellModel: NSObject {
    open var cellData:   AnyObject?
    open var cellClass:  AnyClass?
    open var delegate:   AnyObject?
    open var cellHeight: Float = 44
    open var staticCell: UITableViewCell?
    
    override init() {
        super.init()
    }
    
    public convenience init(cellClass: AnyClass?, cellHeight: Float, cellData: AnyObject?) {
        self.init()
        self.cellClass = cellClass
        self.cellHeight = cellHeight
        self.cellData = cellData
    }

    open class func modelWithCellClass(_ cellClass: AnyClass?, cellHeight: Float, cellData: AnyObject?) -> FDDBaseCellModel {
        let cellModel: FDDBaseCellModel = FDDBaseCellModel(cellClass: cellClass, cellHeight: cellHeight, cellData: cellData)
        return cellModel
    }
    

}
