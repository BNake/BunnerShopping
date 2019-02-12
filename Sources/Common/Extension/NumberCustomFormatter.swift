//
//  MoneyFormatter.swift
//  VIPTemplate
//
//  Created by The Son on 11/25/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit

extension Int {
    func stringDisplay() -> String! {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .decimal
        currencyFormatter.maximumFractionDigits = 2
        currencyFormatter.minimumFractionDigits = 0
        currencyFormatter.locale = Locale.current
        if let priceString = currencyFormatter.string(from: NSNumber(value: self)) {
            return priceString
        } else { return "0" }
    }
}

extension Double {
    func stringDisplay() -> String! {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .decimal
        currencyFormatter.maximumFractionDigits = 2
        currencyFormatter.minimumFractionDigits = 0
        currencyFormatter.locale = Locale.current
        if let priceString = currencyFormatter.string(from: NSNumber(value: self)) {
            return priceString
        } else { return "0" }
    }
}

extension Float {
    func stringDisplay() -> String! {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .decimal
        currencyFormatter.maximumFractionDigits = 2
        currencyFormatter.minimumFractionDigits = 0
        currencyFormatter.locale = Locale.current
        if let priceString = currencyFormatter.string(from: NSNumber(value: self)) {
            return priceString
        } else { return "0" }
    }
}

class NumberCustomFormatter {
    class func stringDisplay(fromNumer: Double) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .decimal
        currencyFormatter.maximumFractionDigits = 2
        currencyFormatter.minimumFractionDigits = 0
        currencyFormatter.locale = Locale.current
        if let priceString = currencyFormatter.string(from: NSNumber(value: fromNumer)) {
            return priceString
        } else { return "0" }
    }
    
    class func moneyDisplay(fromNumer: Double) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.maximumFractionDigits = 2
        currencyFormatter.minimumFractionDigits = 0
        currencyFormatter.locale = Locale.current
        if let priceString = currencyFormatter.string(from: NSNumber(value: fromNumer)) {
            return priceString
        } else { return "" }
    }
    
    class func displayString(currencyCode: String, amount: Double) -> String? {
        let amountNumber = NSNumber(value: amount)
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        currencyFormatter.maximumFractionDigits = 2
        currencyFormatter.minimumFractionDigits = 0
        currencyFormatter.currencyCode = currencyCode
        currencyFormatter.negativeFormat = "-¤#,##0.00"
        if let displayString = currencyFormatter.string(from: amountNumber) {
            return displayString
        } else {
            return nil
        }
    }
}

extension TimeInterval {
    var minuteSecondMS: String {
        return String(format:"%d:%02d.%03d", minute, second, millisecond)
    }
    var minute: Int {
        return Int((self/60).truncatingRemainder(dividingBy: 60))
    }
    var second: Int {
        return Int(truncatingRemainder(dividingBy: 60))
    }
    var millisecond: Int {
        return Int((self*1000).truncatingRemainder(dividingBy: 1000))
    }
}

extension Int {
    var msToSeconds: Double {
        return Double(self) / 1000
    }
}
