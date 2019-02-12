//
//  AppDelegate.swift
//  VIPTemplate
//
//  Created by Tue Nguyen on 4/13/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import IQKeyboardManagerSwift
  
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let appCenter = AppCenter.shared
    
    static let shared = UIApplication.shared.delegate as? AppDelegate

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Fabric.with([Crashlytics.self])
        LoggerSetup()
        LogInfo("Started App version \(AppInfo.version())")
        appCenter.setup()
        appCenter.preloadStaticData()
        IQKeyboardManager.shared.enable = true
        NotificationManager.sharedInstance.registerRemoteNotification()
        showHome()
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
       
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {

    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        NetworkConnectionManager.shared.startNetworkReachabilityObserver()

    }
    
    func applicationWillResignActive(_ application: UIApplication) {

    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // iOS 9
    }
    
    func registerGlobalEvents() {

    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return URLHandler.sharedInstance.handle(application: app, open: url, options: options)
    }
}
  
extension AppDelegate {
    func showHome() {
        let loginViewController = PageTabHomeConfigurator.viewcontroller()
        let navigation = UINavigationController(rootViewController: loginViewController)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
}
