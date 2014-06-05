//
//  UserListTableViewController.swift
//  TQKey
//
//  Created by naoty on 2014/06/04.
//  Copyright (c) 2014年 Naoto Kaneko. All rights reserved.
//

import UIKit

class UserListTableViewController: UITableViewController {
    var userList: UserList = UserList()
    var client: AFHTTPRequestOperationManager
    
    init(coder aDecoder: NSCoder!) {
        let url = NSURL(string: "http://intense-dawn-3408.herokuapp.com")
        self.client = AFHTTPRequestOperationManager(baseURL: url)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func successCallback(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) {
            let json = responseObject as Dictionary<String, Dictionary<String, AnyObject>[]>
            userList = UserList(JSONDictionary: json)
            tableView.reloadData()
        }
        
        func failureCallback(operation: AFHTTPRequestOperation!, error: NSError!) {
            NSLog("error: \(error)")
        }

        self.client.GET("/users.json", parameters: nil, success: successCallback, failure: failureCallback)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // #pragma mark - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return userList.users.count
    }

    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!  {
        var cell = tableView.dequeueReusableCellWithIdentifier("UserCell") as UITableViewCell
        cell.textLabel.text = userList.users[indexPath.row].name
        return cell
    }
}
