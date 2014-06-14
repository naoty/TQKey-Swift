//
//  APIClient.swift
//  TQKey
//
//  Created by naoty on 2014/06/07.
//  Copyright (c) 2014年 Naoto Kaneko. All rights reserved.
//

import Foundation

protocol APIClientDelegate {
    func didLoadUserList(userList: UserList)
}

class APIClient: AFHTTPRequestOperationManager {
    // How can I make weak delegate in Swift?
    var delegate: APIClientDelegate?
    
    init() {
        super.init(baseURL: NSURL(string: "http://tqchain.herokuapp.com"))
    }
    
    func loadUserList() {
        func successCallback(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) {
            let json = responseObject as Dictionary<String, AnyObject>[]
            let userList = UserList(JSON: json)
            self.delegate?.didLoadUserList(userList)
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
        
        func failureCallback(operation: AFHTTPRequestOperation!, error: NSError!) {
            NSLog("Error: \(error)")
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        GET("/users", parameters: nil, success: successCallback, failure: failureCallback)
    }
    
    func updateUser(user: User #home: Bool) {
        let parameter = ["home": home]
  
        func failureCallback(operation: AFHTTPRequestOperation!, error: NSError!) {
            NSLog("Error: \(error)")
        }
        
        PATCH("/users/\(user.id)", parameters: parameter, success: nil, failure: failureCallback)
    }
}
