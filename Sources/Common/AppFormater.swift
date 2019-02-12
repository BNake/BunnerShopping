//
//  AppFormater.swift
//  VIPTemplate
//
//  Created by Tue Nguyen on 10/5/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit

class AppFormater {
    static func timeAgoString(date: Date) -> String {
        return ""
    }
}

let iso8601Formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(abbreviation: "UTC")
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    return formatter
}()

let commentFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(abbreviation: "UTC")
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return formatter
}()
