//
//  LoginResponse.swift
//  VIPTemplate
//
//  Created by Tue Nguyen on 6/6/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import Foundation

struct AuthenResponse: Codable {
    var token = ""
    var userInfo: UserProfile?
    
    enum CodingKeys: String, CodingKey {
        case token
        case userInfo
    }
}
