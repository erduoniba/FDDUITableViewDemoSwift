//
//  FDDBaseViewController.swift
//  FDDUITableViewDemoSwift
//
//  Created by denglibing on 2017/2/14.
//  Copyright © 2017年 denglibing. All rights reserved.
//  Demo: https://github.com/erduoniba/FDDUITableViewDemoSwift
//

import UIKit
import PullToRefresh

// MARK: 依赖房多多的FDDCustomerCommon/BaseViewController 和 GitHub的PullToRefresher
open class FDDBaseTableViewController: UIViewController, FDDBaseTableViewCellDelegate {
    
    open var dataArr = NSMutableArray()
    open var tableView: UITableView!
    open var tableViewConverter: FDDTableViewConverter!
    var tableViewStyle: UITableViewStyle = .plain
    
    open var pageIndex: Int = 0
    open var pageSize: Int = 20
    
    fileprivate var haveTopRefresh: Bool = false
    fileprivate var haveBottomRefresh: Bool = false
    
    deinit {
        if haveTopRefresh {
            tableView.removePullToRefresh(tableView.topPullToRefresh!)
        }
        if haveBottomRefresh {
            tableView.removePullToRefresh(tableView.bottomPullToRefresh!)
        }
    }
    
    // 1:初始化带TableView的Controller
    convenience public init(tableViewStyle style: UITableViewStyle) {
        self.init()
        
        tableViewStyle = style
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        self.edgesForExtendedLayout = []
        
        tableViewConverter = FDDTableViewConverter.init(withTableViewCarrier: self, dataSources: self.dataArr)
        tableView = UITableView(frame: self.view.bounds, style: tableViewStyle)
        tableView.autoresizingMask = [UIViewAutoresizing.flexibleHeight,
                                      UIViewAutoresizing.flexibleTopMargin,
                                      UIViewAutoresizing.flexibleBottomMargin,
                                      UIViewAutoresizing.flexibleWidth,
                                      UIViewAutoresizing.flexibleLeftMargin,
                                      UIViewAutoresizing.flexibleRightMargin]
        tableView.delegate = tableViewConverter
        tableView.dataSource = tableViewConverter
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
    }

    // 2:给TableViewController添加下拉刷新数据功能，子类重载 requestData 方法来刷新数据
    open func addRefresgView(at position: Position) {
        switch position {
        case .top:
            if !haveTopRefresh {
                haveTopRefresh = true
                tableView.addPullToRefresh(FDDPullToRefresher(at: .top)) { [weak self] in
                    withExtendedLifetime(self){
                        self?.pageIndex = 0
                        self?.requestData()
                    }
                }
            }
            break

        case .bottom:
            if !haveBottomRefresh {
                haveBottomRefresh = true
                tableView.addPullToRefresh(FDDPullToRefresher(at: .bottom)) { [weak self] in
                    withExtendedLifetime(self){
                        self?.pageIndex += 1
                        self?.requestData()
                    }
                }
            }
            break
        }
    }

    // 2.1: 刷新追加后的回调方法
    open func requestData() {

    }

    // 3:停止刷新和追加
    open func endRefreshing(at position: Position) {
        self.tableView.endRefreshing(at: position)
    }
    
    // 4:隐藏上拉或者上拉刷新控件
    open func hideRefreshView(at postopn: Position) {
        switch postopn {
        case .top:
            if haveTopRefresh {
                self.tableView.removePullToRefresh(tableView.topPullToRefresh!)
                haveTopRefresh = false

            }
            break
        case .bottom:
            if haveBottomRefresh {
                self.tableView.removePullToRefresh(tableView.bottomPullToRefresh!)
                haveBottomRefresh = false
            }
            break
        }
    }

    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
