//
//  ViewController.swift
//  companion
//
//  Created by Yves Songolo on 9/6/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit
import iBeaconManager
import CoreLocation

class ViewController: UIViewController {
    var beaconManager: BeaconManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       beaconManager = AppDelegate.shared.beaconManager
        beaconManager.delegate = self
        self.view.alpha = 0.5
        AttendanceServices.show { (att) in
            print(att?.first?.date)
        }
    }
}
extension ViewController: BeaconManagerDelegate{
    func beaconManager(sender: BeaconManager, isInBeaconRange region: CLRegion) {
        print("inside beacon range")
        self.view.backgroundColor = UIColor.green
    }
    
    func beaconManager(sender: BeaconManager, isNotInBeaconRange region: CLRegion) {
        print("not inside beacon range")
         self.view.backgroundColor = UIColor.white
    }
    
    func beaconManager(sender: BeaconManager, searchingInRegion region: CLRegion) {
        print("searching for beacon")
        UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat, .autoreverse], animations: {
             self.view.backgroundColor = UIColor.yellow
        }, completion: nil)
    }
    
    func beaconManager(sender: BeaconManager, enteredBeaconRegion region: CLRegion) {
        print("entered beacon region")
         self.view.backgroundColor = UIColor.blue
    }
    
    func beaconManager(sender: BeaconManager, exitedBeaconRegion region: CLRegion) {
        print("exited beacon region")
         self.view.backgroundColor = UIColor.red
    }
    
    func beaconManager(sender: BeaconManager, monitoringRegionFailed region: CLRegion, withError error: Error) {
        print("monitoring for beacon failed")
    }
}
