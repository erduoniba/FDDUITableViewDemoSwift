//
//  FDDBaseTableViewCell.swift
//  FDDUITableViewDemoSwift
//
//  Created by denglibing on 2017/2/7.
//  Copyright © 2017年 denglibing. All rights reserved.
//

import UIKit

@objc
public protocol FDDBaseTableViewCellDelegate: NSObjectProtocol {
    @objc optional func fddTableViewCell(cell: FDDBaseTableViewCell, object: AnyObject?)
}


enum FDDBaseTableViewCellType {
    case FDDBaseTableViewCellNone       //上下线都隐藏
    case FDDBaseTableViewCellAtFirst    //下线隐藏,按照group样式即第一个cell,originx=0
    case FDDBaseTableViewCellAtMiddle   //下线隐藏,按照group样式即中间cell,originx=separateLineOffset
    case FDDBaseTableViewCellAtLast     //上下线都显示,按照group样式即最后一个cell,上线originx=separateLineOffset 下线originx=0
    case FDDBaseTableViewCellNormal     //下线隐藏,按照plain样式,originx=separateLineOffset
    case FDDBaseTableViewCellSingle     //上下线都显示，originx=0
}

open class FDDBaseTableViewCell: UITableViewCell {
    
    open weak var fddDelegate: FDDBaseTableViewCellDelegate?
    open var fddIndexPath: IndexPath?
    open var fddCellData: AnyObject?
    open var separateLineOffset: CGFloat = 0.0
    var sizeOnePx: CGFloat = 1.0 / UIScreen.main.scale
    
    var _cellType: FDDBaseTableViewCellType = .FDDBaseTableViewCellNormal
    var cellType: FDDBaseTableViewCellType {
        get {
            return _cellType
        }
        set {
            _cellType = newValue
            
            switch _cellType {
            case .FDDBaseTableViewCellNone:
                topLineView.isHidden = true
                bottomLineView.isHidden = true
                break
                
            case .FDDBaseTableViewCellAtFirst, .FDDBaseTableViewCellAtMiddle, .FDDBaseTableViewCellNormal:
                topLineView.isHidden = false
                bottomLineView.isHidden = true
                break
                
            case .FDDBaseTableViewCellAtLast, .FDDBaseTableViewCellSingle:
                topLineView.isHidden = false
                bottomLineView.isHidden = false
                break
            }
            
            self.setNeedsLayout()
        }
    }
    
    open class func cellHeight(_ data: AnyObject?) -> Float {
        return self.cellHeight(data, boundWidth: Float(UIScreen.main.bounds.size.width))
    }
    
    open class func cellHeight(_ data: AnyObject?, boundWidth: Float) -> Float {
        return 44.0
    }
    
    
    // MARK: - public func
    open func setBorderLine(backgroundColor: UIColor) {
        topLineView.backgroundColor = backgroundColor
        bottomLineView.backgroundColor = backgroundColor
    }
    
    open func setCellData(_ data: AnyObject?) {
        self.setCellData(data, delegate: nil)
        print("子类实现")
    }
    
    open func setCellData(_ data: AnyObject?, delegate: FDDBaseTableViewCellDelegate?) {
        fddCellData = data
        fddDelegate = delegate
        print("子类实现")
    }
    
    open func setSeperatorAtIndexPath(_ indexPath: IndexPath, numberOfRowsInSection: Int) {
        if numberOfRowsInSection == 1 {
            self.cellType = .FDDBaseTableViewCellSingle
        }
        else {
            if indexPath.row == 0 {
                self.cellType = .FDDBaseTableViewCellAtFirst
            }
            else if indexPath.row == numberOfRowsInSection - 1 {
                self.cellType = .FDDBaseTableViewCellAtLast
            }
            else {
                self.cellType = .FDDBaseTableViewCellAtMiddle
            }
        }
    }
    
    
    // MARK: - lazy init
    lazy var topLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 208/255.0, green: 208/255.0, blue: 208/255.0, alpha: 1)
        return view
    }()
    
    lazy var bottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 208/255.0, green: 208/255.0, blue: 208/255.0, alpha: 1)
        return view
    }()
    
    // MARK: - override
    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setup()
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        switch _cellType {
        case .FDDBaseTableViewCellNone:
            topLineView.frame = CGRect(x: separateLineOffset, y: 0.0, width: self.frame.size.width - separateLineOffset, height: sizeOnePx)
            bottomLineView.frame = CGRect(x: separateLineOffset, y: self.bounds.maxY - sizeOnePx, width: self.frame.size.width - separateLineOffset, height: sizeOnePx)
            break
            
        case .FDDBaseTableViewCellAtFirst:
            topLineView.frame = CGRect(x: 0, y: 0.0, width: self.frame.size.width, height: sizeOnePx)
            bottomLineView.frame = CGRect(x: separateLineOffset, y: self.bounds.maxY - sizeOnePx, width: self.frame.size.width - separateLineOffset, height: sizeOnePx)
            break
            
        case .FDDBaseTableViewCellAtMiddle, .FDDBaseTableViewCellNormal:
            topLineView.frame = CGRect(x: separateLineOffset, y: 0.0, width: self.frame.size.width - separateLineOffset, height: sizeOnePx)
            bottomLineView.frame = CGRect(x: separateLineOffset, y: self.bounds.maxY - sizeOnePx, width: self.frame.size.width - separateLineOffset, height: sizeOnePx)
            break
            
        case .FDDBaseTableViewCellAtLast:
            topLineView.frame = CGRect(x: separateLineOffset, y: 0.0, width: self.frame.size.width - separateLineOffset, height: sizeOnePx)
            bottomLineView.frame = CGRect(x: 0, y: self.bounds.maxY - sizeOnePx, width: self.frame.size.width, height: sizeOnePx)
            break
            
        case .FDDBaseTableViewCellSingle:
            topLineView.frame = CGRect(x: 0, y: 0.0, width: self.frame.size.width, height: sizeOnePx)
            bottomLineView.frame = CGRect(x: 0, y: self.bounds.maxY - sizeOnePx, width: self.frame.size.width, height: sizeOnePx)
            break
        }
    }
    
    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    // MARK: - private func
    private func setup() {
        self.selectionStyle = .none
        
        self.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        self.contentView.addSubview(self.topLineView)
        self.contentView.addSubview(self.bottomLineView)
    }

}


