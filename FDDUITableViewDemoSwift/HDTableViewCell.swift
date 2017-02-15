//
//  HDTableViewCell.swift
//  FDDUITableViewDemoSwift
//
//  Created by denglibing on 2017/2/9.
//  Copyright © 2017年 denglibing. All rights reserved.
//

import UIKit

class HDTableViewCell: FDDBaseTableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.textLabel?.font = UIFont.systemFont(ofSize: 14)
        self.textLabel?.numberOfLines = 0;
        self.separateLineOffset = 10;
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tableViewCellAction))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let height: CGFloat = CGFloat(HDTableViewCell.cellHeight(self.fddCellData, boundWidth: Float(self.frame.size.width)))
        self.textLabel?.frame = CGRect(x: 10, y: 10, width: self.frame.size.width - 20, height: height - 20)
    }

    override func setCellData(_ data: AnyObject?, delegate: FDDBaseTableViewCellDelegate?) {
        self.fddCellData = data
        self.fddDelegate = delegate
        self.textLabel?.text = self.fddCellData as? String
    }
    
    override class func cellHeight(_ data: AnyObject?, boundWidth: Float) -> Float {
        let labelText: NSString = data as! NSString
        let dic = NSDictionary(object: UIFont.systemFont(ofSize: 14), forKey: NSFontAttributeName as NSCopying)
        let rect = labelText.boundingRect(with: CGSize(width: CGFloat(boundWidth - 20), height: 999.0),
                                          options: .usesLineFragmentOrigin,
                                          attributes: dic as? [String : Any],
                                          context: nil)
        return 20.0 + Float(rect.size.height)
    }
    
    func tableViewCellAction() -> Void {
        if (self.fddDelegate != nil) && (self.fddDelegate?.responds(to: #selector(FDDBaseTableViewCellDelegate.fddTableViewCell(cell:object:))))! {
            self.fddDelegate?.fddTableViewCell!(cell: self, object: nil)
        }
    }
    
}
