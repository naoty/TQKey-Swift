//
//  User.swift
//  TQKey
//
//  Created by naoty on 2014/06/05.
//  Copyright (c) 2014年 Naoto Kaneko. All rights reserved.
//

import UIKit

class User: NSObject {
    let id: Int = 0
    let name: String = ""
    let email: String = ""
    let home: Bool = true
    let updatedAt: NSDate = NSDate()
    let dateFormatter: NSDateFormatter
    
    init(JSON json: Dictionary<String, AnyObject>) {
        self.dateFormatter = NSDateFormatter()
        self.dateFormatter.timeZone = NSTimeZone(name: "JST")
        self.dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZ"
        
        for (key, value: AnyObject) in json {
            switch key {
            case "id":
                self.id = value as Int
            case "name":
                self.name = value as String
            case "email":
                self.email = value as String
            case "home":
                self.home = value as Bool
            case "updated_at":
                let dateString = value as String
                self.updatedAt = dateFormatter.dateFromString(dateString)
            default:
                continue
            }
        }

        super.init()
    }
}
