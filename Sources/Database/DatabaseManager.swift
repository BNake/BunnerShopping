//
//  DataStore.swift
//  VIPTemplate
//
//  Created by Tue Nguyen on 4/22/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseManager {
    //swiftlint:disable all
    private var realm: Realm!
    //swiftlint:enable all
    
    init() {
        var defaultRealmConfig = Realm.Configuration.defaultConfiguration
        //Migration
        defaultRealmConfig.schemaVersion = 12
//        defaultRealmConfig.migrationBlock = {(migration, oldVersion) in
//            //migration code here
//        }
        Realm.Configuration.defaultConfiguration = defaultRealmConfig
        do {
            self.realm = try Realm(configuration: defaultRealmConfig)
        } catch {
            if let fileURL = defaultRealmConfig.fileURL {
                try? FileManager.default.removeItem(at: fileURL)
                self.realm = try? Realm(configuration: defaultRealmConfig)
            }
        }
        LogInfo("Realm Database: \(self.realm.configuration.fileURL?.absoluteString ?? "")")
    }
    
    func clearRealm() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {

        }
    }
    
    func save(_ block: ((_ realm: Realm) -> Void)) {
        try? self.realm.write {
            block(self.realm)
        }
    }

    // MARK: Base function
    private func saveObjects<S>(_ objects: S) -> Bool where S: Sequence, S.Element: RealmSwift.Object {
        do {
            try realm.write {
                self.realm.add(objects, update: true)
            }
        } catch {
            return false
        }
        return true
    }
    
    private func deleteObjects<S>(_ objects: S) -> Bool where S: Sequence, S.Element: RealmSwift.Object {
        do {
            try realm.write {
                self.realm.delete(objects)
            }
        } catch {
            return false
        }
        return true
    }
    
    private func saveObject(_ object: Object) -> Bool {
        do {
            try realm.write {
                self.realm.add(object, update: true)
            }
        } catch {
            return false
        }
        return true
    }
    
    private func deleteObject(_ object: Object) -> Bool {
        do {
            try realm.write {
                self.realm.delete(object)
            }
        } catch {
            return false
        }
        return true
    }
}
