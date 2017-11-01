//
//  RaoKouLingEntity.swift
//  Rao
//
//  Created by Iracle Zhang on 04/11/2016.
//  Copyright © 2016 Iracle. All rights reserved.
//

import Foundation
import RealmSwift

class RaoKouLingEntity: Object {
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
//    override static func indexedProperties() -> [String] {
//        return ["title"]
//    }
    //property must has a value ""
    @objc dynamic var groupPriority: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var content: String = ""
    
    override class func primaryKey() -> String {
        return "title"
    }
}


