//
//  AppDelegate.swift
//  Spider
//
//  Created by 廣瀬雄大 on 2017/05/23.
//  Copyright © 2017年 廣瀬雄大. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var spiderWindow: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let edge: CGFloat = 48
        let spiderButton = SpiderButton(
            image: #imageLiteral(resourceName: "add"),
            highlightedImage: nil,
            center: CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY),
            edge: edge
            )!
        spiderButton.eventButtons = [
            SpiderEventButton(image: #imageLiteral(resourceName: "fb"), highlightedImage: nil, edge: edge)!,
            SpiderEventButton(image: #imageLiteral(resourceName: "gh"), highlightedImage: nil, edge: edge)!,
            SpiderEventButton(image: #imageLiteral(resourceName: "tw"), highlightedImage: nil, edge: edge)!,
            SpiderEventButton(image: #imageLiteral(resourceName: "link"), highlightedImage: nil, edge: edge)!,
            SpiderEventButton(image: #imageLiteral(resourceName: "insta"), highlightedImage: nil, edge: edge)!
            ]
        
        let rootViewController = ViewController.initialViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        navigationController.view.addSubview(spiderButton)
        
//        spiderWindow = SpiderWindow(spiderButton: spiderButton, frame: UIScreen.main.bounds)
//        spiderWindow?.rootViewController = UIViewController()
////        spiderWindow?.rootViewController?.view.backgroundColor = .clear
////        spiderWindow?.backgroundColor = .clear
//        spiderWindow?.makeKeyAndVisible()
        
        window?.makeKeyAndVisible()
        
        return true
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

