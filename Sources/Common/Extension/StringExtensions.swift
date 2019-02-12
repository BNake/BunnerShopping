//
//  StringExtensions.swift
//  VIPTemplate
//
//  Created by The Son on 11/23/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit

extension String {
    func convertFromHTML() -> NSAttributedString{
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }

    func detectLink() -> String {
        var string = ""
        let types: NSTextCheckingResult.CheckingType = [ .link]
        let detector = try? NSDataDetector(types: types.rawValue)
        detector?.enumerateMatches(in: self, options: [], range: NSMakeRange(0, self.length), using: { (result, flags, _) in
            if let link = result?.url, string.length == 0 {
                string = link.absoluteString
            }
        })
        return string
    }
    
    func split(regex pattern: String) -> [String] {
        guard let re = try? NSRegularExpression(pattern: pattern, options: []) else {
            return []
        }
        let nsString = self as NSString
        let stop = "<SomeStringThatYouDoNotExpectToOccurInSelf>"
        let modifiedString = re.stringByReplacingMatches(
            in: self,
            options: [],
            range: NSRange(location: 0, length: nsString.length),
            withTemplate: stop)
        return modifiedString.components(separatedBy: stop)
    }
    
    var isNumberOrDouble: Bool {
        return Double(self.trimmingCharacters(in: .whitespaces)) != nil
    }
    
    var appVersion: String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
        return "\(version)"
    }
    
    var appBuild: String {
        let dictionary = Bundle.main.infoDictionary!
        let build = dictionary["CFBundleVersion"] as! String
        return "\(build)"
    }
    
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.endIndex.encodedOffset)) {
            return match.range.length == self.endIndex.encodedOffset
        } else {
            return false
        }
    }
}
