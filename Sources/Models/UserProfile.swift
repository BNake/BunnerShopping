//
//  UserProfile.swift
//  VIPTemplate
//
//  Created by Tue Nguyen on 11/1/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import Foundation

struct UserProfile: Codable {
    var userID = ""
    var fullName = ""
    var email = ""
    
    enum CodingKeys: String, CodingKey {
        case userID = "id"
        case fullName = "full_name"
        case email
    }
}
