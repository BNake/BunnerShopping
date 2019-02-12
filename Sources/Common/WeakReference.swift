//
//  WeakReference.swift
//  VIPTemplate
//
//  Created by Tue Nguyen on 11/23/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit

class WeakReference<T: AnyObject> {
    weak var object: T?
    init(_ object: T) {
        self.object = object
    }
}

class Observers<T: AnyObject> {
    private(set) var innerObservers = [WeakReference<T>]()
    
    func add(_ observer: T) {
        innerObservers.append(WeakReference(observer))
    }
    func remove(_ observer: T) {
        innerObservers.removeIf(closure: { (value) -> Bool in
            if let object = value.object, object === observer {
                return true
            } else {
                return false
            }
        })
    }
    
    func removeAll() {
        innerObservers.removeAll()
    }
    // Remove all object that don't have reference
    func removeZeroReferences() {
        innerObservers.removeIf(closure: { (value) -> Bool in
            return value.object == nil
        }, firstMatch: false)
    }
    
    func forEach(_ closure: ((_ object: T) -> Void)) {
        for observer in innerObservers {
            if let object = observer.object {
                closure(object)
            }
        }
    }
}
