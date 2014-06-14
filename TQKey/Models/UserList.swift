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
    
    init(JSON jsonObjects: Dictionary<String, AnyObject>[]) {
        users = []
        
        for jsonObject in jsonObjects {
            let user = User(JSON: jsonObject)
            users.append(user)
        }
        
        super.init()
    }
    
    convenience init() {
        self.init(JSON: [])
    }
    
    func findUser(byName name: String) -> User? {
        let filteredUsers = self.users.filter { user in user.name == name }
        return filteredUsers[0]
    }
}
