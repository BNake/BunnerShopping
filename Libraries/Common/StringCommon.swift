//
//  StringCommon.swift
//  VIPTemplate
//
//  Created by Tue Nguyen on 6/6/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import Foundation
extension String {
    /**
     Return length of the current string
     */
    var length: Int {
        return self.count
    }
    
    /**
    Triming white space from start and end of the string
    */
    func trim() -> String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func replace(_ target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
//
//    subscript (r: Range<Int>) -> String {
//        get {
//            let startIndex = self.characters.index(self.startIndex, offsetBy: r.lowerBound)
//            let endIndex = self.characters.index(self.startIndex, offsetBy: r.upperBound)
//            return String(self[startIndex..<endIndex])
//        }
//    }
    
//    func subString(_ startIndex: Int, length: Int) -> String {
//        let start = self.characters.index(self.startIndex, offsetBy: startIndex)
//        let end = self.characters.index(self.startIndex, offsetBy: startIndex + length)
//        return String(self[Range<String.Index>(start..<end)])
//    }
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
/**
 * String file path processing
 */
extension String {
    public var lastPathComponent: String {
        return (self as NSString).lastPathComponent
    }
    
    public var deletingLastPathComponent: String {
        return (self as NSString).deletingLastPathComponent
    }
    
    public func appendingPathComponent(_ str: String) -> String {
        return (self as NSString).appendingPathComponent(str)
    }
    
    public var pathExtension: String {
        return (self as NSString).pathExtension
    }
    
    public var deletingPathExtension: String {
        return (self as NSString).deletingPathExtension
    }
    
    public func appendingPathExtension(_ str: String) -> String? {
        return (self as NSString).appendingPathExtension(str)
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension String {
    func index(of string: String, options: CompareOptions = .literal) -> Index? {
        return range(of: string, options: options)?.lowerBound
    }
    
    func endIndex(of string: String, options: CompareOptions = .literal) -> Index? {
        return range(of: string, options: options)?.upperBound
    }
    
    func indexes(of string: String, options: CompareOptions = .literal) -> [Index] {
        var result: [Index] = []
        var start = startIndex
        while let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range.lowerBound)
            start = range.upperBound
        }
        return result
    }
    
    func ranges(of string: String, options: CompareOptions = .literal) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var start = startIndex
        while let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range)
            start = range.upperBound
        }
        return result
    }
}
