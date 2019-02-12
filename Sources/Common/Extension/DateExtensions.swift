//
//  DateExtensions.swift
//  VIPTemplate
//
//  Created by Hieu Nguyen on 11/6/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import Foundation

private struct Helper {
    static func localizedStrings(for key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
    static func string(from format: String, with value: Int) -> String {
        let localeFormat = String(format: format, localeFormatUnderscores(with: Double(value)))
        return String(format: localizedStrings(for: localeFormat), value)
    }
    
    static func localeFormatUnderscores(with value: Double) -> String {
        guard let localeCode = Locale.preferredLanguages.first else {
            return ""
        }
        
        // Russian (ru) and Ukrainian (uk)
        if localeCode.hasPrefix("ru") || localeCode.hasPrefix("uk") {
            let XY = Int(floor(value)) % 100
            let Y = Int(floor(value)) % 10
            
            if Y == 0 || Y > 4 || (XY > 10 && XY < 15) {
                return ""
            }
            
            if Y > 1 && Y < 5 && (XY < 10 || XY > 20) {
                return "_"
            }
            
            if Y == 1 && XY != 11 {
                return "__"
            }
        }
        
        return ""
    }
}

extension Date {
    var millisecondsSince1970: Int64 {
        return Int64(self.timeIntervalSince1970 * 1000.0)
    }
    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(Double(milliseconds) / 1000.0))
    }
    
    // MARK: - Time Ago
    
    // shows 1 or two letter abbreviation for units.
    // does not include 'ago' text ... just {value}{unit-abbreviation}
    // does not include interim summary options such as 'Just now'
    func timeAgoSimple() -> String {
        let components = self.dateComponents()
        
        if let year = components.year, year > 0 {
            return Helper.string(from: "%%d%@yr", with: year)
        }
        
        if let month = components.month, month > 0 {
            return Helper.string(from: "%%d%@mo", with: month)
        }
        
        // TODO: localize for other calanders
        if let day = components.day  {
            if day >= 7 {
                let value = day / 7
                return Helper.string(from: "%%d%@w", with: value)
            } else if day > 0 {
                return Helper.string(from: "%%d%@d", with: day)
            }
        }
        
        if let hour = components.hour, hour > 0 {
            return Helper.string(from: "%%d%@h", with: hour)
        }
        
        if let minute = components.minute, minute > 0 {
            return Helper.string(from: "%%d%@m", with: minute)
        }
        
        if let second = components.second, second > 0 {
            return Helper.string(from: "%%d%@s", with: second)
        }
        
        return ""
    }
    
    func timeAgo(_ showHour: Bool = false) -> String {
        let components = self.dateComponents()
        // TODO: localize for other calanders
        let calendar = NSCalendar.current
        if calendar.isDateInToday(self) {
            if let hour = components.hour, hour > 0 {
                if hour < 2 {
                    return Helper.localizedStrings(for: "An hour ago")
                } else  {
                    return Helper.string(from: "%%d %@hours ago", with: hour)
                }
            }
            
            if let minute = components.minute, minute > 0 {
                if minute < 2 {
                    return Helper.localizedStrings(for: "A minute ago")
                } else {
                    return Helper.string(from: "%%d %@minutes ago", with: minute)
                }
            }
            
            if let second = components.second, second > 0 {
                if second < 5 {
                    return Helper.localizedStrings(for: "Just now")
                } else {
                    return Helper.string(from: "%%d %@seconds ago", with: second)
                }
            }
            
            return Helper.localizedStrings(for: "Just now")
        } else if calendar.isDateInYesterday(self) {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            formatter.dateStyle = .none
            let timeString = formatter.string(from: self)
            return Helper.localizedStrings(for: "Yesterday") + " at " + timeString
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM dd"
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            let dateString = formatter.string(from: self)
            formatter.timeStyle = .short
            formatter.dateStyle = .none
            let timeString = formatter.string(from: self)
            
            return dateString + " at " + timeString
        }
    }
    
    func timeAgoForChatConversation() -> String {
        let components = self.dateComponents()
        // TODO: localize for other calanders
        let calendar = NSCalendar.current
        if calendar.isDateInToday(self) {
            if let hour = components.hour, hour > 0 {
                if hour < 2 {
                    return Helper.localizedStrings(for: "An hour ago")
                } else  {
                    return Helper.string(from: "%%d %@hours ago", with: hour)
                }
            }
            
            if let minute = components.minute, minute > 0 {
                if minute < 2 {
                    return Helper.localizedStrings(for: "A minute ago")
                } else {
                    return Helper.string(from: "%%d %@minutes ago", with: minute)
                }
            }
            
            if let second = components.second, second > 0 {
                if second < 5 {
                    return Helper.localizedStrings(for: "Just now")
                } else {
                    return Helper.string(from: "%%d %@seconds ago", with: second)
                }
            }
            
            return Helper.localizedStrings(for: "Just now")
        } else if calendar.isDateInYesterday(self) {
            return Helper.localizedStrings(for: "Yesterday")
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM dd"
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            return formatter.string(from: self)
        }
    }
    
    func timeAgoWithSpecificTimeForToday() -> String {
        // TODO: localize for other calanders
        let calendar = NSCalendar.current
        if calendar.isDateInToday(self) {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            formatter.dateStyle = .none
            return formatter.string(from: self)
        } else if calendar.isDateInYesterday(self) {
            return Helper.localizedStrings(for: "Yesterday")
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM dd"
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            return formatter.string(from: self)
        }
    }
    
    func dateString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "MMMM dd"
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: self)
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        let timeString = formatter.string(from: self)
        
        return dateString + " at " + timeString
    }
    
    fileprivate func dateComponents() -> DateComponents {
        return Calendar.current.dateComponents([.second, .minute, .hour, .day, .month, .year], from: self, to: Date())
    }
}
