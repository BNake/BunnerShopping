//
//  API.swift
//  VIPTemplate
//
//  Created by Tue Nguyen on 10/25/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit
import Alamofire
import PromiseKit

extension APIClient {
    // MARK: - Login - Signup
    @discardableResult
    func login(email: String, password: String) -> Promise<AuthenResponse> {
        let params: Parameters = ["credential": email,
                                  "password": password]
        return request(.post, "/api/users/login", parameters: params, encoding: JSONEncoding.default).responseTask()
    }
    
    @discardableResult
    func login(socialType: String, socialId: String, socialToken: String, socialSecret: String) -> Promise<AuthenResponse> {
        let params: Parameters = ["social_type": socialType,
                                  "social_id": socialId,
                                  "token": socialToken,
                                  "secret": socialSecret]
        return request(.post, "/api/helo/users/social-signin", parameters: params, encoding: JSONEncoding.default).responseTask()
    }
}

