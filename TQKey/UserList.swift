//
//  UserList.swift
//  TQKey
//
//  Created by naoty on 2014/06/05.
//  Copyright (c) 2014年 Naoto Kaneko. All rights reserved.
//

import UIKit

class UserList: NSObject {
    var users: User[] = []
    
    init() {
        super.init()
    }
    
    init(JSONDictionary json: Dictionary<String, Dictionary<String, AnyObject>[]>) {
        super.init()
        
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
                    default:
                        continue
                    }
                }
                users.append(user)
            }
        }
    }
}
