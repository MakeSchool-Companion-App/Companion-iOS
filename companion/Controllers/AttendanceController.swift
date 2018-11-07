//
//  AttendanceController.swift
//  companion
//
//  Created by Uchenna  Aguocha on 9/28/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit
import CoreLocation
class AttendanceController: UIViewController {
    
    // MARK: - Properties
    let locationManager = CLLocationManager()
    var attendance = [Attendance]() {
        didSet {
            DispatchQueue.main.async {
                self.attendanceTableView.reloadData()
            }
            
        }
    }
    
    var inRange = false
    
    static let shared = AttendanceController()
    // MARK: - UI Elements
    
    lazy var attendanceTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9019607843, blue: 0.9607843137, alpha: 1)
        tableView.register(AttendanceCell.self, forCellReuseIdentifier: AttendanceCell.attendanceCellId)
        return tableView
    }()
    
    // MARK: - View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAutoLayout()
        setupNavbarItem()
        
        GeoFenceServices.startMonitoringMakeschool { (started) in
            if started {
                self.locationManager.delegate = self
                self.locationManager.startUpdatingLocation()
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest//kCLLocationAccuracyBestForNavigation
               // self.locationManager.allowsBackgroundLocationUpdates = true
                 self.locationManager.pausesLocationUpdatesAutomatically = false
            }
        }
        

        
        AttendanceServices.show { (att) in
            print(att)
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintAdjustmentMode = .normal
        self.navigationController?.navigationBar.tintAdjustmentMode = .automatic
    }
    
    // MARK: - UI Setup Methods
    
    private func setupNavbarItem() {

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "beaconNavItem"), style: .plain, target: self, action: #selector(tapBeaconNavItem))
    
    }
    
    private func setupAutoLayout() {
        
        view.addSubview(attendanceTableView)
        
        attendanceTableView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            bottom: view.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            topPadding: 0,
            rightPadding: 0,
            bottomPadding: 0,
            leftPadding: 0,
            height: 0,
            width: 0)
        
    }
    
    // MARK: - Methods with @objc attribute
    
    @objc private func tapBeaconNavItem() {
        print("Test: Beacon Nav Item Tapped....")
        
        let scanBeaconController = ScanBeaconController()
        self.navigationController?.present(scanBeaconController, animated: true, completion: nil)
        
    }
}

// MARK: - TableView Delegate & DataSource Methods
extension AttendanceController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attendance.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AttendanceCell.attendanceCellId, for: indexPath) as? AttendanceCell else {
            fatalError("Failed to initialize Attendance Cell")
        }
        
        let studentAttendance = attendance[indexPath.row]
        
        cell.checkInDateLabel.text = studentAttendance.event_in
        cell.checkOutTimeLabel.text = studentAttendance.event_in
        cell.checkInTimeLabel.text = studentAttendance.checkInTime
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    
}

extension AttendanceController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
        //self.presentAlert(title: "did enter", message: "enter in the region")
        
        
        // check if the attendance was already taken to avoid double check in
        if AttendanceServices.isTodayAttendanceDone() == true{ return}
        
      //  if region.identifier == Constants.makeSchoolRegionId {
            let attendance = Attendance.init(event: .onEntry, beaconId: Constants.makeSchoolRegionId, event_in: Date().checkTime(), event_out: Constants.eventOutEmptyFormat, id: 0, user_id: 0)
            
            AttendanceServices.create(attendance) { (att) in
                if let checkInAttendance = att{
                     self.presentAlert(title: "post attendance", message: "posrt attendance completeted")
                    /// store the date and id of the last attendance for future verification
                    UserDefaults.standard.set(checkInAttendance.id, forKey: Constants.attendanceId)
                    
                    UserDefaults.standard.set(checkInAttendance.event_in, forKey: Constants.eventId)
                    
                    
                    /// save today attendance
                     AppDelegate.shared.attendanceNotification(attendance: attendance)
                }
            }
        //}
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print(region.identifier)
        self.presentAlert(title: "did Exit", message: "exiting the region")
        if region.identifier == Constants.makeSchoolRegionId {
            
            //let id = UserDefaults.standard.value(forKey: Constants.attendanceId) as! Int
            AttendanceServices.fetchLastAttendance { (lastAttendance) in
                lastAttendance.event_out = Date().checkTime()
                AttendanceServices.update(attendance: lastAttendance, completion: { (updatedAttendance) in
                    AppDelegate.shared.attendanceNotification(attendance: updatedAttendance)
                })
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            //let cord = CLLocationCoordinate2D(latitude: 37.787871, longitude: -122.410966)
            let msCoordinate = CLLocation(latitude: 37.787689, longitude: -122.410929)
            let distance = location.distance(from: msCoordinate)
            self.title = String(distance)
            if distance < 50 {
                
                if inRange == true{
                //self.presentAlert(title: "out of range", message: "you left make school")
                    
                    // check if the attendance was already taken to avoid double check in
                    if AttendanceServices.isTodayAttendanceDone() == true{ return}
                    
                    let attendance = Attendance.init(event: .onEntry, beaconId: Constants.makeSchoolRegionId, event_in: Date().checkTime(), event_out: Constants.eventOutEmptyFormat, id: 0, user_id: 0)
                    
                    AttendanceServices.create(attendance) { (att) in
                        if let checkInAttendance = att{
                           
                            /// store the date and id of the last attendance for future verification
                            UserDefaults.standard.set(checkInAttendance.id, forKey: Constants.attendanceId)
                            
                            UserDefaults.standard.set(checkInAttendance.event_in, forKey: Constants.eventId)
                            
                            AttendanceServices.markAttendance()
                            /// save today attendance
                            AppDelegate.shared.attendanceNotification(attendance: attendance)
                        }
                    }
                    inRange = false
                }
            }
            else{
                if inRange == false{
                 //self.presentAlert(title: "in range", message: "you enter make school")
                    if AttendanceServices.isTodayAttendanceDone() == false {return}
                    AttendanceServices.fetchLastAttendance { (lastAttendance) in
                        lastAttendance.event_out = Date().checkTime()
                        AttendanceServices.update(attendance: lastAttendance, completion: { (updatedAttendance) in
                            AppDelegate.shared.attendanceNotification(attendance: updatedAttendance)
                        })
                    }
                    
                inRange = true
                }
            }
            
        }
    }
}
