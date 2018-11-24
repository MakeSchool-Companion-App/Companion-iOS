//
//  ScanBeaconController.swift
//  companion
//
//  Created by Uchenna  Aguocha on 9/12/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit
import iBeaconManager
import CoreLocation



class ScanBeaconController: UIViewController {
    
    // MARK: Properties
    
    var beaconManager: BeaconManager?
    
    // MARK: - UI Elements
    
    let beaconView = BeaconView()
    
    let beaconStatusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.numberOfLines = 2
        return label
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(handleCancellation), for: .touchUpInside)
        return button
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "arrow-left"), for: .normal)
        button.layer.cornerRadius = self.view.frame.height
        button.addTarget(self, action: #selector(showAttendanceController), for: .touchUpInside)
        button.backgroundColor = .white
        return button
    }()
    
    
    
    // MARK: - View Life Cyle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.05490196078, green: 0.1921568627, blue: 0.8117647059, alpha: 0.9730308219)
        setupBeaconManager()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupAutoLayout()
        beaconView.startPulsatingAnimation()
    }
    
    func setupBeaconManager() {
        beaconManager = AppDelegate.shared.beaconManager
        beaconManager?.delegate = self
        beaconManager?.startMonitoring()
    }
    
    // MARK: - Setup UI Methods

    func setupAutoLayout() {

        view.addSubviews(views: beaconView, beaconStatusLabel, cancelButton)

        beaconView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            bottom: nil,
            left: view.safeAreaLayoutGuide.leftAnchor,
            topPadding: 0,
            rightPadding: 0,
            bottomPadding: 0,
            leftPadding: 0,
            height: 300,
            width: 0)
        
        beaconStatusLabel.anchor(
            top: beaconView.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            bottom: nil,
            left: view.safeAreaLayoutGuide.leftAnchor,
            topPadding: 30,
            rightPadding: 20,
            bottomPadding: 0,
            leftPadding: 20,
            height: 65,
            width: 0)
        
//        cancelButton.anchor(
//            top: nil,
//            right: nil,
//            bottom: view.safeAreaLayoutGuide.bottomAnchor,
//            left: nil,
//            topPadding: 60,
//            rightPadding: 0,
//            bottomPadding: 20,
//            leftPadding: 0,
//            height: 65,
//            width: 224)
//        cancelButton.centerAnchor(centerX: view.centerXAnchor, centerY: nil)  
        
        beaconView.addSubview(backButton)
        backButton.anchor(top: beaconView.topAnchor, right: nil, bottom: nil, left: beaconView.leftAnchor, topPadding: 10, rightPadding: 0, bottomPadding: 0, leftPadding: 22, height: 32, width: 32)
        
    }
    
    // MARK: - Methods with @objc
    
    @objc private func handleCancellation() {
        print("Show Check In & Out History")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func showAttendanceController() {
        print("Test: Show Attendance Controller")
        
        self.dismiss(animated: true, completion: nil)
    }
}

enum BeaconRegionStatus {
    case inRange
    case notInRange
    case searching
    case entered
    case exited
    case failed
}

extension ScanBeaconController: BeaconManagerDelegate {
    
    func beaconManager(sender: BeaconManager, isInBeaconRange region: CLRegion) {
        print("Beacon is in range.")
        // Create a timestamp (Attendance) once you're in the region
       
        view.backgroundColor = MakeSchoolDesignColor.darkBlue
    }
    
    func beaconManager(sender: BeaconManager, isNotInBeaconRange region: CLRegion) {
        print("Beacon is not in range")
        view.backgroundColor = MakeSchoolDesignColor.darkBlue
    }
    
    func beaconManager(sender: BeaconManager, searchingInRegion region: CLRegion) {
        print("Search for beacon in region")
        
        view.backgroundColor = MakeSchoolDesignColor.darkBlue
        beaconStatusLabel.text = "Searching for an iBeacon..."
    }
    
    func beaconManager(sender: BeaconManager, enteredBeaconRegion region: CLRegion) {
        print("Entered Beacon Region")
        view.backgroundColor = MakeSchoolDesignColor.darkBlue
        beaconStatusLabel.text = "Found an iBeacon"
//        UIView.animateKeyframes(
//            withDuration: 3.0,
//            delay: 0.0,
//            options: [],
//            animations: {
//                self.beaconView.beaconImageView.image = UIImage(contentsOfFile: "checkmark")
//        }, completion: nil)
    }
    
    func beaconManager(sender: BeaconManager, exitedBeaconRegion region: CLRegion) {
        print("Exited Beacon Region")
        view.backgroundColor = MakeSchoolDesignColor.darkBlue
        beaconStatusLabel.text = "Exited an iBeacon region"
    }
    
    func beaconManager(sender: BeaconManager, monitoringRegionFailed region: CLRegion, withError error: Error) {
        print("Failed to monitor beacon \(error)")
        view.backgroundColor = MakeSchoolDesignColor.darkBlue
        beaconStatusLabel.text = "Failed to find an iBeacon"
    }
    

}


