//
//  NotificationManager.swift
//  VIPTemplate
//
//  Created by Tue Nguyen on 6/6/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

class NotificationManager: NSObject, UIApplicationDelegate {
    
    var deviceToken: String? {
        didSet {
            self.registerPushToken()
        }
    }
    static let sharedInstance: NotificationManager = {
        let instance = NotificationManager()
        return instance
    }()
    
    // Handle push from background or when app's launched by tapping remote push
    func handlePendingNotificationIfNeeded() {

    }
    
    func registerRemoteNotification() {
        // Request if there's no device token
        guard self.deviceToken == nil else {
            self.registerPushToken()
            return
        }
        
        let application: UIApplication = UIApplication.shared
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: {_, _ in
            })
            
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        requestToken()
        
    }
    
    func requestToken() {
        InstanceID.instanceID().instanceID { result, error in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
                self.deviceToken = result.token
            }
        }
    }
    
    func registerPushToken() {
        if let _ = UIDevice.current.identifierForVendor?.uuidString, let fcmToken = deviceToken, fcmToken.count > 0 {
            // Async call, dont need to handle error

        }
    }
    
    func disableRemoteNotification() {
        let application = UIApplication.shared
        application.applicationIconBadgeNumber = 0
//        let notificationType: UIUserNotificationType = UIUserNotificationType()
//        let settings = UIUserNotificationSettings(types: notificationType, categories: nil)
//        application.registerUserNotificationSettings(settings)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        requestToken()
    }
    
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
//        self.deviceToken = fcmToken
//    }
}

//extension NotificationManager: MessagingDelegate {
//    func application(received remoteMessage: MessagingRemoteMessage) {
//    }
//}

extension NotificationManager: UNUserNotificationCenterDelegate {
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
    }

    @available(iOS 10.0, *)
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        debugPrint(notification)
        // App is in the foreground
        guard AppCenter.shared.userSession.isAuthenticated else {
            return
        }
        if let userInfo = notification.request.content.userInfo as? [String: Any] {
            NotificationHandler.shared.handle(pushContent: userInfo, fromBackground: false)
        }
        
        NotificationCenter.default.post(name: NSNotification.Name.needUpdateBadge, object: nil)
    }
}

