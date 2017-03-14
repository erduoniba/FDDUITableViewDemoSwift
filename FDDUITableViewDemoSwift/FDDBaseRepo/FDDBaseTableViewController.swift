//
//  FDDBaseViewController.swift
//  FDDUITableViewDemoSwift
//
//  Created by denglibing on 2017/2/14.
//  Copyright © 2017年 denglibing. All rights reserved.
//

import UIKit

// MARK: 依赖房多多的FDDCustomerCommon/BaseViewController 和 GitHub的PullToRefresher
open class FDDBaseTableViewController: UIViewController {
    
    var dataArr = NSMutableArray()
    var tableView: UITableView!
    var tableViewConverter: FDDTableViewConverter!
    var tableViewStyle: UITableViewStyle = .plain
    
    var pageIndex: Int = 0
    var pageSize: Int = 20
    
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
    open func addRefreshView() {
        haveTopRefresh = true
        tableView.addPullToRefresh(FDDPullToRefresh(at: .top)) { [weak self] in
            withExtendedLifetime(self){
                self?.pageIndex = 0
                self?.requestData()
            }
        }
    }
    
    // 2:给TableViewController添加上拉追加更多数据功能，子类重载 requestData 方法来刷新数据
    open func addLoadMoreView() {
        haveBottomRefresh = true
        tableView.addPullToRefresh(FDDPullToRefresh(at: .bottom)) { [weak self] in
            withExtendedLifetime(self){
                self?.pageIndex += 1
                self?.requestData()
            }
        }
    }
    
    // MARK: 刷新追加后的回调方法
    open func requestData() {
        
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
