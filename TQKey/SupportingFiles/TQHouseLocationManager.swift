//
//  TQHouseLocationManager.swift
//  TQKey
//
//  Created by naoty on 2014/06/07.
//  Copyright (c) 2014年 Naoto Kaneko. All rights reserved.
//

import UIKit
import CoreLocation

protocol TQHouseLocationManagerDelegate {
    func didEnterTQHouseRegion()
    func didExitTQHouseRegion()
}

class TQHouseLocationManager: NSObject, CLLocationManagerDelegate {
    var delegate: TQHouseLocationManagerDelegate?
    let locationManager: CLLocationManager
    
    init() {
        self.locationManager = CLLocationManager()
        super.init()
        
        self.locationManager.delegate = self
    }
    
    func startMonitoring() {
        if !CLLocationManager.isMonitoringAvailableForClass(CLCircularRegion) {
            return
        }
        
        let tqhouse = CLLocationCoordinate2D(latitude: 35.627076, longitude: 139.70318)
        let region = CLCircularRegion(center: tqhouse, radius: 10, identifier: "naoty.tqkey")
        locationManager.startMonitoringForRegion(region)
    }
    
    // #pragma mark - CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        self.delegate?.didEnterTQHouseRegion()
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        self.delegate?.didExitTQHouseRegion()
    }
}
