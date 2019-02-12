//
//  AppCenter.swift
//  VIPTemplate
//
//  Created by Tue Nguyen on 7/26/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit
import Alamofire

class AppCenter {
    static let shared = AppCenter()
    let currentEnvKey = "CurrentEnv"
    let lastActiveDateKey = "LastActiveDate"
    //swiftlint:disable all
    private (set) var userSession: UserSession!
    private (set) var databaseManager: DatabaseManager!
    private (set) var apiClient: APIClient!
    private (set) var settingManager: SettingManager!
    //swiftlint:enable all
    private init() {
        loadCurrentEnv()
    }

    private(set) lazy var notificationManager: NotificationManager = {
        return NotificationManager()
    }()
    
    func loadCurrentEnv() {
        #if PROD || STAGE
            return
        #else
            let userPref = UserDefaults.standard
            if let envName = userPref.string(forKey: currentEnvKey),
                let env = Environment.all.filter({ $0.name == envName }).first {
                Environment.current = env
            }
        #endif
    }
    
    func setup() {
        userSession = UserSession()
        apiClient = APIClient(baseURLString: Environment.current.serviceURL)
        apiClient.accessToken = userSession.accessToken()
        apiClient.authenticator = { [unowned self] (headers: inout HTTPHeaders, params: inout Parameters) in
            if let accessToken = self.apiClient.accessToken {
                headers["authorization"] = "Bearer \(accessToken)"
            }
        }
        databaseManager = DatabaseManager()
        AppTheme.applyGlobalStyle()
        settingManager = SettingManager()
        userSession.checkFirstTimeOpenApp()
    }
    
    func userDidLogin() {
    }
    
    func userDidLogout() {
    }
    
    func preloadData() {
    }

    func preloadStaticData() {
    }
    
    open func switchEnv(env: Environment) {
        let userPref = UserDefaults.standard
        userPref.set(env.name, forKey: currentEnvKey)
        userPref.synchronize()
        
        Environment.current = env
        setup()
    }
    
    func checkUpdate(needUpdate: @escaping (_:Bool) -> ()) {
        
    }
}
