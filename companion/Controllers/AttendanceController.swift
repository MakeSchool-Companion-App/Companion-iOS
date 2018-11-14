//
//  AttendanceController.swift
//  companion
//
//  Created by Uchenna  Aguocha on 9/28/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications


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
    var onPost = false
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
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                 self.locationManager.pausesLocationUpdatesAutomatically = false
            }
        }
         //UserDefaults.standard.set("", forKey: Constants.savedAttendance)
//        AttendanceServices.fetchLastAttendance { (lastAttendance) in
//            lastAttendance.event_out = Date().checkTime()
//            lastAttendance.event_in = lastAttendance.event_in!.replacingOccurrences(of: " ", with: "+",
//                                                options: NSString.CompareOptions.literal, range:nil)
//            lastAttendance.event = EventType.onExit.rawValue
//            AttendanceServices.update(attendance: lastAttendance, completion: { (updatedAttendance) in
//                AppDelegate.shared.attendanceNotification(attendance: updatedAttendance)
//            })
//        }
        
        AttendanceServices.show { (att) in
            if let attendance = att{
            self.attendance = attendance
            }
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
        
        cell.checkInDateLabel.text = studentAttendance.checkInDate
        cell.checkInTimeLabel.text = studentAttendance.checkInTime
        cell.checkOutTimeLabel.text = studentAttendance.checkOutTime
        cell.checkOutDateLabel.text = studentAttendance.event_out
        
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
        
      ///  if region.identifier == Constants.makeSchoolRegionId {
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
        
        
       
        
        if region.identifier == Constants.makeSchoolRegionId {
            
            AttendanceServices.fetchLastAttendance { (lastAttendance) in
                lastAttendance.event_out = Date().checkTime()
                AttendanceServices.update(attendance: lastAttendance, completion: { (updatedAttendance) in
                    AppDelegate.shared.attendanceNotification(attendance: updatedAttendance)
                })
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            //let cord = CLLocationCoordinate2D(latitude: 37.787871, longitude: -122.410966)
            let msCoordinate = CLLocation(latitude: 37.787689, longitude: -122.410929)
            let natomaCoordinate = CLLocation(latitude: 37.767343, longitude:  -122.418581)
          
            let distance = location.distance(from: natomaCoordinate)
//             self.title = String(distance)
            if distance < 50 {
                
                // check if the attendance was already taken to avoid double check in
                if AttendanceServices.isTodayAttendanceDone() == true{ return}
                
                if onPost == false{
                    onPost = true
                //self.presentAlert(title: "out of range", message: "you left make school")
                    
                    let attendance = Attendance.init(event: .onEntry, beaconId: Constants.makeSchoolRegionId, event_in: Date().checkTime(), event_out: Constants.eventOutEmptyFormat, id: 0, user_id: 0)
                    
                    AttendanceServices.create(attendance) { (att) in
                        if let checkInAttendance = att{
                            AttendanceServices.fetchLastAttendance(id: String(checkInAttendance.id!), completion: { (attendance) in
                               
                                /// store the date and id of the last attendance for future verification
                                UserDefaults.standard.set(attendance.id, forKey: Constants.attendanceId)
                                
                                UserDefaults.standard.set(attendance.event_in, forKey: Constants.eventId)
                                
                                
                                
                                AttendanceServices.markAttendance()
                                self.presentAlert(title: "Check in", message: "You enter Make School at \(attendance.checkInTime ?? "") ")
                                AppDelegate.shared.attendanceNotification(attendance: attendance)
                            })
                        }
                    }
                }
            }
            else{
               
                    if AttendanceServices.isTodayAttendanceDone() == false {return}
                AttendanceServices.fetchLastAttendance { (lastAttendance) in
                    lastAttendance.event_out = Date().checkTime()
                    lastAttendance.event_in = lastAttendance.event_in!.replacingOccurrences(of: " ", with: "+",
                                                                                            options: NSString.CompareOptions.literal, range:nil)
                    lastAttendance.event = EventType.onExit.rawValue
                    AttendanceServices.update(attendance: lastAttendance, completion: { (updatedAttendance) in
                         self.presentAlert(title: "Check out", message: "You left Make School at \(updatedAttendance.checkOutTime ?? "") ")
                        AppDelegate.shared.attendanceNotification(attendance: updatedAttendance)
                    })
                }
            }
            
        }
    }
}
