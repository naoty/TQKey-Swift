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
        super.init(baseURL: NSURL(string: "http://intense-dawn-3408.herokuapp.com"))
    }
    
    func loadUserList() {
        func successCallback(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) {
            let json = responseObject as Dictionary<String, Dictionary<String, AnyObject>[]>
            let userList = UserList(JSONDictionary: json)
            self.delegate?.didLoadUserList(userList)
            dispatch_async(dispatch_get_main_queue(), {
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            })
        }
        
        func failureCallback(operation: AFHTTPRequestOperation!, error: NSError!) {
            NSLog("Error: \(error)")
            dispatch_async(dispatch_get_main_queue(), {
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            })
        }
        
        dispatch_async(dispatch_get_main_queue(), {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        })
        
        GET("/users.json", parameters: nil, success: successCallback, failure: failureCallback)
    }
    
    func updateUser(#name: String, athome: Bool) {
        let parameter = ["user": ["athome": athome]]
  
        func failureCallback(operation: AFHTTPRequestOperation!, error: NSError!) {
            NSLog("Error: \(error)")
        }
        
        PUT("/users/\(name).json", parameters: parameter, success: nil, failure: failureCallback)
    }
}
