//
//  ArrayExtensions.swift
//  VIPTemplate
//
//  Created by Tue Nguyen on 11/3/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit

extension Array {
    mutating func removeIf(closure:((Element) -> Bool), firstMatch: Bool = true) {
        for index in (0 ..< self.count).reversed() {
            if closure(self[index]) {
                self.remove(at: index)
                if firstMatch {
                    return
                }
            }
        }
    }
}

extension Array where Element: Equatable {
    mutating func removeObject(object: Element) {
        if let index = self.index(of: object) {
            self.remove(at: index)
        }
    }
    
    mutating func removeObjectsInArray(array: [Element]) {
        for object in array {
            self.removeObject(object: object)
        }
    }
}
