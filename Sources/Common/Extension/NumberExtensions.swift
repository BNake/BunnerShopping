//
//  NumberExtensions.swift
//  VIPTemplate
//
//  Created by Savvycom on 11/2/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import Foundation

extension Int {
    var arrayOfDigit: [Int] {
        return String(self).compactMap{ Int(String($0)) }
    }

    func toString() -> String {
        return String(format: "%d", self)
    }
    
    func toFollowNumber(_ size: CGFloat = 14) -> NSAttributedString {
        var text = self.toString() + " Followers"
        if self == 1 {
            text = self.toString() + " Follower"
        }
        let textRange = text.startIndex..<text.endIndex
        let attributedString = NSMutableAttributedString(string: text)
        text.enumerateSubstrings(in: textRange, options: .byWords) { (substring, substringRange, _, _) in
            if substring == "Follower" || substring == "Followers" {
                attributedString.addAttribute(.font, value: UIFont.robotoRegularFont(size), range: NSRange(substringRange, in: text))
            } else {
                attributedString.addAttribute(.font, value: UIFont.robotoMediumFont(size), range: NSRange(substringRange, in: text))
            }
        }
        
        return attributedString
    }
    
    func toCommentNumber() -> String {
        if self == 1 {
            return "1 comment"
        } else if self <= 0 {
            return ""
        } else {
            return "\(self) comments"
        }
    }
    
    func toLikeNumber() -> String {
        if self == 1 {
            return "1 Person like this"
        } else if self <= 0 {
            return ""
        } else {
            return "\(self) People like this"
        }
    }
}

extension Double {
    func toString() -> String {
        return toString(fraction: 0)
    }
    
    func toString(fraction: Int) -> String {
        return String(format: "%.\(fraction)f", self)
    }
    
    func toDistanceKm() -> String {
        let formatter = NumberFormatter()
        
        formatter.minimumIntegerDigits = 1
        formatter.roundingMode = .halfUp
        
        if (self < 1000.0) {
            formatter.maximumFractionDigits = 0
            let stringInMet = formatter.string(from: NSNumber(value: self))
            return stringInMet! + " m"
        } else {
            formatter.maximumFractionDigits = 1
            let stringInKm = formatter.string(from: NSNumber(value: self/1000.0))
            return stringInKm! + " km"
        }
    }
    
    func toHour() -> String {
        let formatter = NumberFormatter()
        
        formatter.minimumIntegerDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.roundingMode = .halfUp
        
        let hours = self / 3600
        
        if Int(hours) == 0 {
            let minutes = (self.truncatingRemainder(dividingBy: 3600)) / 60
            formatter.maximumFractionDigits = 0
            if Int(minutes) == 1 {
                return formatter.string(from: NSNumber(value: minutes))! + " Minute"
            } else {
                return formatter.string(from: NSNumber(value: minutes))! + " Minutes"
            }
        } else if Int(hours) == 1 {
            return formatter.string(from: NSNumber(value: hours))! + " Hour"
        } else {
            return formatter.string(from: NSNumber(value: hours))! + " Hours"
        }
    }
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Int {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}
