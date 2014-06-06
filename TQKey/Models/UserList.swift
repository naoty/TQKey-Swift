//
//  UserList.swift
//  TQKey
//
//  Created by naoty on 2014/06/05.
//  Copyright (c) 2014年 Naoto Kaneko. All rights reserved.
//

import UIKit

class UserList: NSObject {
    var users: User[]
    let dateFormatter: NSDateFormatter
    
    init(JSONDictionary json: Dictionary<String, Dictionary<String, AnyObject>[]>) {
        users = []
        
        dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "JST")
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZ"
        
        if let userObjects = json["users"] {
            for userObject in userObjects {
                let user = User()
                for (key, value: AnyObject) in userObject {
                    switch key {
                    case "name":
                        user.name = value as String
                    case "email":
                        user.email = value as String
                    case "athome":
                        user.athome = value as Bool
                    case "updated_at":
                        let dateString = value as String
                        user.updatedAt = dateFormatter.dateFromString(dateString)
                    default:
                        continue
                    }
                }
                users.append(user)
            }
        }
        
        super.init()
    }
    
    convenience init() {
        self.init(JSONDictionary: ["users": []])
    }
}
