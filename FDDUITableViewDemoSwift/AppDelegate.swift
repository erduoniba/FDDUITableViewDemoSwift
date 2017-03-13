//
//  AppDelegate.swift
//  FDDUITableViewDemoSwift
//
//  Created by denglibing on 2017/2/7.
//  Copyright © 2017年 denglibing. All rights reserved.
//

import UIKit

typealias resultBlock = (_ params: Array<Any>) -> Any

typealias MyClosure = (_ a: Int, _ b: Int) -> Int

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let resultBlocks = { (val1: Int, Val2: Int) -> Int in
            return val1 + Val2
        }
        
        
        self.register(index: 0) { (param: Array) -> Any in
            return 1
        }
        
        print("result: \(resultBlocks(12, 43))")
        
        
        typealias MyClosure = (_ a: Int, _ b: Int) -> Int
        var closure : MyClosure?
        closure = { (a: Int, b: Int) -> Int in
            return a+b
        }
        print(closure!(1, 2));
        
        self.doSomeThing { (a: Int, b: Int) -> Int in
            return a * b
        }
        
        return true
    }
    
    func doSomeThing(closure: MyClosure) {
        print(closure(1, 2))
    }
    
    func register(index: Int, pram: resultBlock) {
         pram(["1", "2", "2"])
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

