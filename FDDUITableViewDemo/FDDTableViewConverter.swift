//
//  FDDTableViewConverter.swift
//  FDDUITableViewDemo
//
//  Created by denglibing on 2017/2/10.
//  Copyright © 2017年 denglibing. All rights reserved.
//

import UIKit

class FDDTableViewConverter: NSObject {
    
    weak var vc: UIViewController?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if ((vc?.fddTableViewConverter["tableView: numberOfRowsInSection:"]) != nil) {
            
        }
        
        return 1
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
