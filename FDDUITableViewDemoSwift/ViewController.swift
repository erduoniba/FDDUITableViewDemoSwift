//
//  ViewController.swift
//  FDDUITableViewDemoSwift
//
//  Created by denglibing on 2017/2/7.
//  Copyright © 2017年 denglibing. All rights reserved.
//

import UIKit
//import FeedBackIOS

/// 使用注册方式统一处理 UITableViewDataSource和UITableViewDelegate， 特殊的方法使用注册模式处理
class ViewController: FDDBaseViewController {
    
    deinit {
        print(NSStringFromClass(ViewController.self) + " dealloc")
    }
    
    var tableViewConverter : FDDTableViewConverter?
    
//    var bugWindow : FDDBugWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "ViewController";
        
        self.disposeDataSources()
        self.disposeTableViewConverter()
        
//        bugWindow = FDDBugWindow.sharedInstance
//        bugWindow?.isHidden = true;       //是否隐藏提bug按钮，隐藏后将只支持摇一摇提bug
//        bugWindow?.redmineProjectId = 158;    //项目Id， 2表示经纪人iOS
//        bugWindow?.redminePriorityId = 10;  //默认问题优先级
//        bugWindow?.redmineUrl = "https://redmine.fangdd.net/issues.json";    //redmine后台地址
//        bugWindow?.redmineKey = "e31cace473b669d5b4d954c3365b09e3d63cc25c";   //redmine token
//        bugWindow?.run();                   //启动
    }
    
    func disposeDataSources () {
        let randomSources = ["Swift is now open source!",
                             "We are excited by this new chapter in the story of Swift. After Apple unveiled the Swift programming language, it quickly became one of the fastest growing languages in history. Swift makes it easy to write software that is incredibly fast and safe by design. Now that Swift is open source, you can help make the best general purpose programming language available everywhere",
                             "For students, learning Swift has been a great introduction to modern programming concepts and best practices. And because it is now open, their Swift skills will be able to be applied to an even broader range of platforms, from mobile devices to the desktop to the cloud.",
                             "Welcome to the Swift community. Together we are working to build a better programming language for everyone.",
                             "– The Swift Team"]
        
        for _ in 0...30 {
            let randomIndex: Int = Int(arc4random() % 5)
            let cellData: String = randomSources[randomIndex]
            let cellModel = FDDBaseCellModel.modelWithCellClass(HDTableViewCell.self, cellHeight: HDTableViewCell.cellHeight(cellData as AnyObject?, boundWidth: Float(self.view.frame.size.width)), cellData: cellData as AnyObject?)
            self.dataArr.add(cellModel)
        }
    }
    
    func disposeTableViewConverter() {
        tableViewConverter = FDDTableViewConverter.init(withTableViewCarrier: self, dataSources: self.dataArr)
        
        let tableView: UITableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.delegate = tableViewConverter
        tableView.dataSource = tableViewConverter
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        
        tableViewConverter?.registerTableViewMethod(selector: #selector(UITableViewDelegate.tableView(_:didSelectRowAt:)), handleParams: { [weak self]  (params: Array) -> AnyObject? in
            withExtendedLifetime(self){
                self?.navigationController?.pushViewController(ViewController2(), animated: true)
                }!
            return nil
        })
        
        tableViewConverter?.registerTableViewMethod(selector: #selector(UITableViewDataSource.tableView(_:cellForRowAt:)), handleParams: { [weak self] (params : Array) -> AnyObject? in
            return withExtendedLifetime(self){ () -> FDDBaseTableViewCell in
                let tableView: UITableView = params[0] as! UITableView
                let indexPath: IndexPath = params[1] as! IndexPath
                let cellModel: FDDBaseCellModel = self?.dataArr.object(at: indexPath.row) as! FDDBaseCellModel
                let cell: FDDBaseTableViewCell = tableView.cellForIndexPath(indexPath, cellClass: cellModel.cellClass)!
                cell.setCellData(cellModel.cellData, delegate: self)
                cell.setSeperatorAtIndexPath(indexPath, numberOfRowsInSection: (self?.dataArr.count)!)
                return cell
            }
        })
        
        tableViewConverter?.registerTableViewMethod(selector: #selector(UITableViewDelegate.tableView(_:heightForRowAt:)), handleParams: { [weak self] (params: Array) -> AnyObject? in
            let height = withExtendedLifetime(self){ () -> CGFloat in
                let indexPath: IndexPath = params[1] as! IndexPath
                let cellModel: FDDBaseCellModel = self?.dataArr.object(at: indexPath.row) as! FDDBaseCellModel
                return CGFloat(cellModel.cellHeight)
            }
            
            return height as AnyObject?
        })
    }
    
    override internal func fddTableViewCell(cell: FDDBaseTableViewCell, object: AnyObject?) {
        print("xxx")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

