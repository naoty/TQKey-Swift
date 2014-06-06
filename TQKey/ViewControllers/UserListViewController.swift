//
//  UserListViewController.swift
//  TQKey
//
//  Created by naoty on 2014/06/04.
//  Copyright (c) 2014年 Naoto Kaneko. All rights reserved.
//

import UIKit

class UserListViewController: UITableViewController {
    var userList: UserList = UserList()
    let client: AFHTTPRequestOperationManager
    let dateFormatter: NSDateFormatter
    
    init(coder aDecoder: NSCoder!) {
        let url = NSURL(string: "http://intense-dawn-3408.herokuapp.com")
        client = AFHTTPRequestOperationManager(baseURL: url)
        
        dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "JST")
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd HH':'mm':'ss"
        
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
        let cell = tableView.dequeueReusableCellWithIdentifier("UserCell") as UITableViewCell
        
        let user = userList.users[indexPath.row]
        cell.textLabel.text = user.athome ? "いる" : "いない"
        cell.detailTextLabel.text = dateFormatter.stringFromDate(user.updatedAt)
        cell.imageView.image = GravatarImage(email: user.email)
        
        return cell
    }
}
