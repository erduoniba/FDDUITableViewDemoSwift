//
//  FDDTableViewConverter.swift
//  FDDUITableViewDemo
//
//  Created by denglibing on 2017/2/10.
//  Copyright © 2017年 denglibing. All rights reserved.
//

import UIKit

class FDDTableViewConverter: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    weak var vc: UIViewController?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        if (vc?.responds(to: #selector(UITableViewDataSource.tableView(_:numberOfRowsInSection:))))! {
//            let rows = vc?.perform(#selector(UITableViewDataSource.tableView(_:numberOfRowsInSection:)), with: tableView, with: String(section)).takeRetainedValue()
//            return rows as! Int
//        }
        
        let sel:Selector = Selector(("dddd"))
        if (vc?.responds(to: sel))! {
            let height: NSNumber = vc?.perform(sel).takeRetainedValue() as! NSNumber
            print("height: \(height.intValue)")
        }
        
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (vc?.responds(to: #selector(UITableViewDataSource.tableView(_:cellForRowAt:))))! {
            let cell: FDDBaseTableViewCell = vc?.perform(#selector(UITableViewDataSource.tableView(_:cellForRowAt:)), with: tableView, with: indexPath).takeRetainedValue() as! FDDBaseTableViewCell
            
            return cell
        }
        
        
        
        return FDDBaseTableViewCell()
    }
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sel = #selector(tableView(_:heightForRowAt:))
        if (vc?.responds(to: sel))! {
            let height = vc?.perform(sel, with: tableView, with: indexPath).takeRetainedValue()
            return height as! CGFloat
        }
        
        return 44.0
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

extension UIViewController {
    
    private struct AssociatedKeys {
        static var fddTableViewConverter: NSMutableDictionary?
    }
    
    var fddTableViewConverter: NSMutableDictionary {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.fddTableViewConverter) as! NSMutableDictionary
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.fddTableViewConverter, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
    func fddRegisterTableViewMethod(_ method: String, handle: ((AnyObject) -> Void) ) {
        self.fddTableViewConverter.setValue(handle, forKey: method)
    }
}
