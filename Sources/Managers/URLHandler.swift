//
//  URLHandler.swift
//  VIPTemplate
//
//  Created by The Son on 11/10/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit

class URLHandler {
    static let sharedInstance: URLHandler = {
        let instance = URLHandler()
        return instance
    }()
    
    func handle(application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return true
    }
}
