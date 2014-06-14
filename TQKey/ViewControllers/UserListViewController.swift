//
//  UserListViewController.swift
//  TQKey
//
//  Created by naoty on 2014/06/04.
//  Copyright (c) 2014年 Naoto Kaneko. All rights reserved.
//

import UIKit

class UserListViewController: UITableViewController, APIClientDelegate, TQHouseLocationManagerDelegate {
    var userList: UserList = UserList()
    let client: APIClient
    let dateFormatter: NSDateFormatter
    let locationManager: TQHouseLocationManager
    
    init(coder aDecoder: NSCoder!) {
        client = APIClient()
        
        dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "JST")
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd HH':'mm':'ss"
        
        locationManager = TQHouseLocationManager()
        
        super.init(coder: aDecoder)
        
        client.delegate = self
        locationManager.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        client.loadUserList()
        locationManager.startMonitoring()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didTappedReloadButton(sender: AnyObject) {
        client.loadUserList()
    }

    // #pragma mark - APIClientDelegate

    func didLoadUserList(userList: UserList) {
        self.userList = userList
        self.tableView.reloadData()
    }

    // #pragma mark - TQHouseLocationManager

    func didEnterTQHouseRegion() {
        if let user = self.userList.findUser(byName: "naoty") {
            self.client.updateUser(user, home: true)
        }
    }
    
    func didExitTQHouseRegion() {
        if let user = self.userList.findUser(byName: "naoty") {
            self.client.updateUser(user, home: false)
        }
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
        cell.textLabel.text = user.home ? "いる" : "いない"
        cell.detailTextLabel.text = dateFormatter.stringFromDate(user.updatedAt)
        cell.imageView.image = GravatarImage(email: user.email)
        
        return cell
    }
}
