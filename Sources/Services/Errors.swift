//
//  Response.swift
//  VIPTemplate
//
//  Created by Tue Nguyen on 5/23/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import Foundation

public struct ServiceError: LocalizedError {
    public enum ServiceErrorCode: String {
        case undefined, unauthenticated, emptyResponse, invalidDataFormat, timeout
        case emailUnique = "EMAIL_UNIQUE"
        case emailMax = "EMAIL_MAX"
        case usernameUnique = "USERNAME_UNIQUE"
        case usernameMax = "USERNAME_MAX"
        case incorrectEmail = "INCORRECT_EMAIL"
        case incorrectPassword = "INCORRECT_PASSWORD"
        case userSuppended = "USER_SUSPENDED"
        case accountNotExist = "ACCOUNT_NOT_EXIST"
    }
    
    static let undefined = ServiceError(code: .undefined, reason: NSLocalizedString("undefine", comment: ""))
    static let unauthenticated = ServiceError(code: .unauthenticated, reason: NSLocalizedString("unauthenticate", comment: ""))
    static let emptyResponse = ServiceError(code: .emptyResponse, reason: NSLocalizedString("empty response", comment: ""))
    static let invalidDataFormat = ServiceError(code: .invalidDataFormat, reason: NSLocalizedString("invalid data fomart", comment: ""))
    static let timeout = ServiceError(code: .timeout, reason: NSLocalizedString("request time out", comment: ""))
    static let userSuppended = ServiceError(code: .userSuppended, reason: NSLocalizedString("user suppended", comment: ""))
    
    private (set) var code: String
    private (set) var reason: String
    
    init(code: ServiceErrorCode, reason: String) {
        self.code = code.rawValue
        self.reason = reason
    }
    
    init(code: String, reason: String) {
        self.code = code
        self.reason = reason
    }
    
    public var errorDescription: String? {
        get {
            return self.reason
        }
    }
}
