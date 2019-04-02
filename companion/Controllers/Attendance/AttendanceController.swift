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
import NVActivityIndicatorView


class AttendanceController: UIViewController {
    
    // MARK: - Properties
    
    let locationManager = AppDelegate.shared.locationManager

    var attendance = [Attendance]() {
        didSet {
            DispatchQueue.main.async {
                self.attendanceTableView.reloadData()
            }
        }
    }
    var squareRegionDelegate: RegionProtocol!
    var squareRegionProtocol: RegionDelegateProtocol!
    var onPost = false
    var onUpdate = false
    
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
    
    var customAlertView: CustomAlertView = {
        let view = CustomAlertView(title: "Could Not Connect", message: "Please check your connection and try again.")
        return view
    }()
    
   // method to fetch data and reload table

    func reloadTable(){
        
        configureActivityIndicator()
        AttendanceServices.show { (att) in
            if let attendance = att{
                self.attendance = attendance
            }
        }
    }
    
    
    // MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAutoLayout()
        setupNavbarItem()
        setupNotificationCenter()
        
        
        GeoFenceServices.startMonitoringMakeschool { (started) in
            if started {
                self.locationManager.requestAlwaysAuthorization()
                self.locationManager.delegate = self
                self.locationManager.startUpdatingLocation()
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                self.locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters

                self.locationManager.allowsBackgroundLocationUpdates = true


                self.squareRegionDelegate = self
                self.squareRegionProtocol = self
            }
        }
        

        // If the wifi or cellular service is disconnected then show the alert view
        NetworkStatusManager.shared.reachability.whenUnreachable = { reachability in
            
            // this is called on a background thread, but UI updates must
            // be on the main thread:
            
            if reachability.connection == .none || (reachability.connection != .wifi && reachability.connection != .cellular) {
                DispatchQueue.main.async {
                    self.customAlertView.show(animated: true)
                }
            }
        }
        
        // If the wifi or cellular service is connected then dimiss the alert view
        NetworkStatusManager.shared.reachability.whenReachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread:
            if reachability.connection == .wifi || reachability.connection == .cellular {
                DispatchQueue.main.async {
                    self.customAlertView.dismiss(animated: true)
                }
            }
        }
        
        reloadTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintAdjustmentMode = .normal
        self.navigationController?.navigationBar.tintAdjustmentMode = .automatic
    }
    
    // MARK: - UI Setup Methods
    
    private func setupNavbarItem() {

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "beaconNavItem").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(tapBeaconNavItem))

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
    
    // Sets up the positions and adds the activity indicator on the screen
    private func configureActivityIndicator() {
        
        Constants.indicatorView = NVActivityIndicatorView(frame: CGRect(x: view.frame.midX, y: view.frame.midY, width: view.frame.width/8, height: view.frame.height/8), type: .lineScale, color: .gloomyBlue, padding: 0)
        Constants.indicatorView.center = view.center
        view.addSubview(Constants.indicatorView)
        Constants.indicatorView.startAnimating()
    }
    
    private func setupNotificationCenter() {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (requestedAuth, error) in
            if (requestedAuth) {
                print("True")
            } else {
                print("Error message: \(String(describing: error?.localizedDescription))")
            }
        }
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
        cell.checkOutDateLabel.text = studentAttendance.checkOutDate
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = " No attendance..."
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return attendance.count == 0 ? 150: 0
    }

}

extension AttendanceController: CLLocationManagerDelegate{

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{


            let msCoordinate =  CLLocation(latitude: 37.787689, longitude: -122.410929)
            let squareRegion = CKSquareRegion.init(regionWithCenter: msCoordinate.coordinate, sideLength: 0.035, identifier: Constants.makeSchoolRegionId)

            self.squareRegionDelegate.updateRegion(region: squareRegion!, location: location, squareRegionDelegate: self.squareRegionProtocol)
        }
    }

}

extension AttendanceController: RegionProtocol , RegionDelegateProtocol, UNUserNotificationCenterDelegate {

    func didEnterRegion(region: CKSquareRegion) {

        if AttendanceServices.isTodayAttendanceDone() == true{ return}


        let attendance = Attendance.init(event: .onEntry, beaconId: Constants.makeSchoolRegionId, event_in: Date().checkTime(), event_out: Constants.eventOutEmptyFormat, id: 0, user_id: 0)

        AttendanceServices.create(attendance) { (att) in
            if let checkInAttendance = att{
                AttendanceServices.fetchLastAttendance(id: String(checkInAttendance.id!), completion: { (attendance) in

                    /// store the date and id of the last attendance for future verification
                    UserDefaults.standard.set(attendance.id, forKey: Constants.attendanceId)

                    UserDefaults.standard.set(attendance.event_in, forKey: Constants.eventId)



                    AttendanceServices.markAttendance()
                    self.presentAlert(title: "Check in", message: "You enter Make School at \(attendance.checkInTime ?? "") ")
                    self.reloadTable()
                    AppDelegate.shared.attendanceNotification(attendance: attendance)
                })
            }
        }
    }

    func didExitRegion(region: CKSquareRegion) {

        // addition: Adding the method of attendance service isTodayAttendance checkout to save when the checkout was done

        if AttendanceServices.isTodayAttendanceDone() == false {return}
        if AttendanceServices.isTodayAttendanceCheckOut() == true {return}


        AttendanceServices.fetchLastAttendance { (lastAttendance) in
            lastAttendance.event_out = Date().checkTime()
            lastAttendance.event_in = lastAttendance.event_in!.replacingOccurrences(of: " ", with: "+",
                                                                                    options: NSString.CompareOptions.literal, range:nil)
            lastAttendance.event = EventType.onExit.rawValue
            AttendanceServices.update(attendance: lastAttendance, completion: { (updatedAttendance) in
                self.presentAlert(title: "Check out", message: "You left Make School at \(updatedAttendance.checkOutTime ?? "") ")
                AttendanceServices.fetchLastAttendance(completion: { (lastAttendance) in
                    lastAttendance.event = "Exit"
                    AppDelegate.shared.attendanceNotification(attendance: lastAttendance)
                    self.reloadTable()
                    AttendanceServices.markCheckoutDone()
                })
            })
        }
    }
}
