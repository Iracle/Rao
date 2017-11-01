//
//  DBHelper.swift
//  Rao
//
//  Created by Iracle Zhang on 6/19/16.
//  Copyright © 2016 Iracle. All rights reserved.
//

import UIKit
import GameplayKit

let RaoKouLingDb = "RaoKouLing"
let sql_allRecord = "SELECT groupPriority,Title,Content FROM RaoKouLing"
let sql_seletedRecord = "SELECT groupPriority,Title,Content FROM RaoKouLing WHERE groupPriority="


class DBHelper: NSObject {
    
    static let shareInstance = DBHelper()
    var db: OpaquePointer? = nil
    
    func openDb(_ dbName: String) -> Bool {
        let fileName = Bundle.main.path(forResource: dbName, ofType: "db")
        if sqlite3_open(fileName!, &db) == SQLITE_OK {
            print("dataBase open success")
            return true
        } else {
            print("dataBase open failure")
            return false
        }
    }
    
    func closeDb() {
        if sqlite3_close(db) == SQLITE_OK{
            print("close dataBase success")
        }
    }
    
    func recordSetQuery(_ sql: String) -> [RaoKouLingInfo] {
        if !openDb(RaoKouLingDb) {
            return []
        }
        var record = [RaoKouLingInfo]()
        var stmt: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, sql.cString(using: String.Encoding.utf8)!, -1, &stmt, nil) == SQLITE_OK {
            //get record count
            let count = sqlite3_column_count(stmt)
            
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                var aRaoInfo = [String]()
                
                for i in 0..<count {
                    let chars = String(cString: sqlite3_column_text(stmt, i))
                    let str = String(cString: chars, encoding: String.Encoding.utf8)
                    let result = str?.replacingOccurrences(of: "<BR>", with: "")
                    aRaoInfo.append(result!)
                }
                let aRaoModel = RaoKouLingInfo(groupPriority: aRaoInfo[0], title: aRaoInfo[1], content: aRaoInfo[2])
                record.append(aRaoModel)
            }
        }
        return record.shuffle()
    }
}

extension Collection {
    /// Return a copy of `self` with its elements shuffled
    func shuffle() -> [Iterator.Element] {
        var list = Array(self)
        list.shuffle()
        return list
    }
}

extension MutableCollection where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffle() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in startIndex ..< endIndex - 1 {
            let j = Int(arc4random_uniform(UInt32(endIndex - i))) + i
            if i != j {
                self.swapAt(i, j)
            }
        }
    }
}


