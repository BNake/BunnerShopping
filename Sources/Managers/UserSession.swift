//
//  UserSession.swift
//  VIPTemplate
//
//  Created by Tue Nguyen on 4/22/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import Foundation
import KeychainAccess
import PromiseKit

extension Notification.Name {
    static let didLogin = Notification.Name("UserDidLogin")
    static let didLogout = Notification.Name("UserDidLogout")
    static let didUpdateProfile = Notification.Name("UserDidUpdateProfile")
    static let needUpdateBadge = Notification.Name("NeedUpdateBadge")
}

class UserSession {
    struct KeychainKey {
        static let AccessToken = "AccessToken"
        static let UserId = "UserId"
        static let CDN    = "CDN"
    }
    
    init() {
        if let jsonString = UserDefaults.standard.string(forKey: "UserProfile"), let data = jsonString.data(using: .utf8) {
            let jsonDecoder = JSONDecoder()
            do {
                self.user = try jsonDecoder.decode(UserProfile.self, from: data)
            } catch {
                LogDebug("Can not get user profile.")
            }
        }
    }
    
    let keychain = Keychain(service: AppInfo.bundleId())
    private(set) var user: UserProfile? {
        didSet {
            if let user = user {
                let jsonEncoder = JSONEncoder()
                do {
                    let jsonData = try jsonEncoder.encode(user)
                    let jsonString = String(data: jsonData, encoding: .utf8)
                    UserDefaults.standard.set(jsonString, forKey: "UserProfile")
                    UserDefaults.standard.synchronize()
                    NotificationCenter.default.post(name: .didUpdateProfile, object: self, userInfo: ["profile": user])
                } catch {
                    LogDebug("Can not save user profile.")
                }
            } else {
                UserDefaults.standard.removeObject(forKey: "UserProfile")
                UserDefaults.standard.synchronize()
            }
        }
    }

    // MARK: - Methods
    
    func userId() -> Int? {
        if let keychainValue = keychain[KeychainKey.UserId], let value = Int(keychainValue) {
            return value
        }
        
        return nil
    }
    
    func accessToken() -> String? {
        return keychain[KeychainKey.AccessToken]
    }
    
    var isAuthenticated: Bool {
        return accessToken() != nil
    }
    
    func logout() {
        self.cleanUp()
        NotificationCenter.default.post(name: Notification.Name.didLogout, object: nil)
    }
    
    func checkFirstTimeOpenApp() {
        if UserDefaults.standard.value(forKey: "NOT_FIRST_TIME") == nil || !UserDefaults.standard.bool(forKey: "NOT_FIRST_TIME") {
            logout()
            UserDefaults.standard.set(true, forKey: "NOT_FIRST_TIME")
        }
    }
    
    func loadUserProfile() {
        
    }
    
    func loadNotificationSettings() {

    }
    
    // Save CDN
    func saveCDN(_ cdn: String) {
        
        keychain[KeychainKey.CDN] = cdn
    }
    
    // Get CDN
    func getCDN() -> String? {
        
        return keychain[KeychainKey.CDN]
    }
    
    // MARK: - Private functions
    
    func didLoginSuccess(response: AuthenResponse) {
        self.saveToken(response.token)
        if let user = response.userInfo {
            self.saveUserID(user.userID)
            self.user = user
        }
        AppCenter.shared.userDidLogin()
    }
    
    private func saveToken(_ token: String) {
        keychain[KeychainKey.AccessToken] = token
    }
    
    private func saveUserID(_ userID: String) {
        keychain[KeychainKey.UserId] = userID
    }
    
    private func cleanUp() {
        AppCenter.shared.userDidLogout()
        UIApplication.shared.applicationIconBadgeNumber = 0
//        UIApplication.shared.unregisterForRemoteNotifications()
        keychain[KeychainKey.AccessToken] = nil
        keychain[KeychainKey.UserId] = nil
    }
}
