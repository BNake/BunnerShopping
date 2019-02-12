//
//  Constant.swift
//  VIPTemplate
//
//  Created by Tue Nguyen on 4/15/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

/*
 This file is used to define all global application constants
 */

struct Environment {
    let name: String
    let serviceURL: String
    let streamSocketURL: String
    let chatSocketURL: String

    static let dev = Environment(name: "DEV",
                                     serviceURL: "http://helo-staging.savvycom.vn:8081",
                                     streamSocketURL: "http://helo-staging-socket.savvycom.vn:9696",
                                     chatSocketURL: "http://helo-staging-chat.savvycom.vn:8686")
    
    static let staging = Environment(name: "STAGING",
                         serviceURL: "http://helo-staging.savvycom.vn:8081",
                         streamSocketURL: "http://helo-staging-socket.savvycom.vn:9696",
                         chatSocketURL: "http://helo-staging-chat.savvycom.vn:8686")

    static let production = Environment(name: "PROD",
                         serviceURL: "https://dev.lotto4c.com",
                         streamSocketURL: "https://live.VIPTemplate.com",
                         chatSocketURL: "https://chat.VIPTemplate.com")
    
    #if DEBUG
    static var current = dev
    #elseif STAGE
    static var current = staging
    #else
    static var current = production
    #endif
    
    static let all = [dev, staging, production]
}

struct Constant {
    static var GoogleClientId: String = {
        var myDict: NSDictionary?
        if let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") {
            myDict = NSDictionary(contentsOfFile: path)
        }
        if let dict = myDict, let clientId = dict["CLIENT_ID"] as? String {
            return clientId
        }
        return ""
    }()

    ///// Notification
    struct NotificationName {
        static let applicationDidActive = Notification.Name("APPLICATION_DID_ACTIVE")
        static let followDidChanged = Notification.Name("FOLLOW_DID_CHANGED")
        static let friendDidChanged = Notification.Name("FRIEND_DID_CHANGED")
        static let relationDidChanged = Notification.Name("UpdateUserRelattion")
    }

    ///// Document URL
    struct AppURL {
        static let tosURL = URL(string: "http://www.VIPTemplate.com/terms/")
        static let ppURL = URL(string: "http://www.VIPTemplate.com/privacy/")
        static let faqURL = URL(string: "http://www.VIPTemplate.com/faqs/")
    }
    
    ///// External URL
    struct CommonURL {
        static let googleShare = "https://plus.google.com/share"
    }
}
