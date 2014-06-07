//
//  UserList.swift
//  TQKey
//
//  Created by naoty on 2014/06/05.
//  Copyright (c) 2014年 Naoto Kaneko. All rights reserved.
//

import UIKit

class UserList: NSObject {
    let users: User[]
    
    init(JSONDictionary json: Dictionary<String, Dictionary<String, AnyObject>[]>) {
        users = []
        
        if let userObjects = json["users"] {
            for userObject in userObjects {
                let user = User(JSONObject: userObject)
                users.append(user)
            }
        }
        
        super.init()
    }
    
    convenience init() {
        self.init(JSONDictionary: ["users": []])
    }
}
