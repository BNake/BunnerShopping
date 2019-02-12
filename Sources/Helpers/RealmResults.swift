//
//  RealmResults.swift
//  VIPTemplate
//
//  Created by Tue Nguyen on 11/18/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import RealmSwift

extension Results {
    
    func get<T: Object>(offset: Int, limit: Int) -> [T] {
        //create variables
        var lim = 0 // how much to take
        var off = 0 // start from
        var list: [T] = [T]() // results list
        
        //check indexes
        if off <= offset && offset < self.count - 1 {
            off = offset
        }
        if limit > self.count {
            lim = self.count
        } else {
            lim = limit
        }
        
        //do slicing
        for index in off ..< lim {
            if let dog = self[index] as? T {
                list.append(dog)
            }
        }
        
        //results
        return list
    }
}
