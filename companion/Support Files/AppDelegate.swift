//
//  AppDelegate.swift
//  companion
//
//  Created by Yves Songolo on 9/6/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit
import iBeaconManager
import CoreLocation
import UserNotifications
import KeychainSwift

class CustomNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

enum environmentType {
    case development, production
}

let environment:environmentType = .production


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    static let shared = UIApplication.shared.delegate as! AppDelegate
//    static let shared: AppDelegate = AppDelegate()
    
    lazy var beaconManager: BeaconManager = {
        // Register a beacon
        let registeredBeacon = Beacon(uuid: "B9407F30-F5F8-466E-AFF9-25556B57FE6D", major: 44941, minor: 4437, identifier: "God help me")
        // Manage the registered beacon
        let manager = BeaconManager(beacon: registeredBeacon)
        return manager
    }()
    
    let locationManager = CLLocationManager()
    
    // Local Notification
    let center = UNUserNotificationCenter.current()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        // Anything that accesses NavigationBar will contain these default parameters
//        UINavigationBar.appearance().tintColor = .white
//        // This will set the nav bar color to a light red color
//        UINavigationBar.appearance().barTintColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1)
//        // This will disable the navbar's translucency
//        UINavigationBar.appearance().isTranslucent = false
//        // When the tablview is scrolled, this will resize the title text
//        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.blue]
//        // This will make nav bar's font bold
//        UINavigationBar.appearance().prefersLargeTitles = true
//        // Set the color of the font to white
//        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.blue]
        
        switch environment {
        case .development:
            // set web service URL to development
            // set API keys to development
            print("It's for development")
        case .production:
            // set web service URL to production
            // set API keys to production
            print("It's for production")
        }

        
        
        window = UIWindow()
        
        configureInitialRootViewController(for: window)
        
        beaconManager.startMonitoring()
        
//        GeoFenceServices.startMonitoringMakeschool { (started) in
//            if started {
//                self.locationManager.delegate = self
//            }
//        }
        
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (requestAuth, error) in
            print("AppDelegate: Testing Request Authorization")
        }
//        

//        ProjectServices.show(slug: "yveslym-songolo") { (projects) in
//            print(projects)
//        }
//  
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     self.locationManager.delegate = self
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        self.locationManager.delegate = self
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     self.locationManager.delegate = self
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
     self.locationManager.delegate = self
    }
    }

extension AppDelegate: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        let identifier = region.identifier
        
        AttendanceController.shared.presentAlert(title: "did enter", message: "enter in the region")
        
        let att = Attendance.init(event: .onEntry, beaconId: "test", event_in: "test", event_out: "test", id: 0, user_id: 0)
         self.attendanceNotification(attendance: att)
        // check if the attendance was already taken to avoid double check in
        if AttendanceServices.isTodayAttendanceDone() == true{ return}
        
        if identifier == Constants.makeSchoolRegionId {
            let attendance = Attendance.init(event: .onEntry, beaconId: Constants.makeSchoolRegionId, event_in: Date().checkTime(), event_out: Constants.eventOutEmptyFormat, id: 0, user_id: 0)
            AttendanceServices.create(attendance) { (att) in
                if let checkInAttendance = att{
                    
                    /// store the date and id of the last attendance for future verification
                    UserDefaults.standard.set(checkInAttendance.id, forKey: Constants.attendanceId)
                    
                    UserDefaults.standard.set(checkInAttendance.event_in, forKey: Constants.eventId)
                   
                    
                    /// local notification
                    self.attendanceNotification(attendance: checkInAttendance)
                    
                    /// save today attendance
                    AttendanceServices.markAttendance()
                }
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
       
    }
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
         AttendanceController.shared.presentAlert(title: "did Exit", message: "exiting the region")
        if region.identifier == Constants.makeSchoolRegionId {
            
            //let id = UserDefaults.standard.value(forKey: Constants.attendanceId) as! Int
            AttendanceServices.fetchLastAttendance { (lastAttendance) in
                lastAttendance.event_out = Date().checkTime()
                AttendanceServices.update(attendance: lastAttendance, completion: { (updatedAttendance) in
                    self.attendanceNotification(attendance: updatedAttendance)
                })
            }
           
        }
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func attendanceNotification(attendance: Attendance) {
        
        // The notification content
        let content = UNMutableNotificationContent()
        
        switch attendance.event{
            
        case "Entry":
            content.title = "Companion"
            content.subtitle = "Check In"
            content.body = "You entered Make School at \(attendance.checkInTime ?? " ")."
            content.badge = 1
        case "Exit":
            content.title = "Companion"
            content.subtitle = "Check Out"
            content.body = "You left Make School at \(attendance.checkOutTime ?? " ")."
            content.badge = 1
        default: break
        }
        // Adding title, subtitle, body and badge
       
        
        // Triggering the notification
        // Once a person steps inside the building
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        // Getting the notification request
        let request = UNNotificationRequest(identifier: Constants.attendanceNotificationId, content: content, trigger: trigger)
        
        center.add(request, withCompletionHandler: nil)
        
    }
    
}

extension AppDelegate {
    
    func configureInitialRootViewController(for window: UIWindow?) {
        let defualts = UserDefaults.standard
        let initialViewController: UIViewController
        
       
        if let _ = User.current,
           let userData = defualts.object(forKey: Constants.current) as? Data,
           let user = try? JSONDecoder().decode(User.self, from: userData) {
            
            User.setCurrent(user)
            initialViewController = MainTabBarController()
        } else {
            
            //initialViewController = LoginController()
            showOnboardingPage()
        }
        
//        window?.rootViewController = initialViewController
//        window?.makeKeyAndVisible()
    
    }
    
    /// Renders the onboarding page when it's a first time user
    func showOnboardingPage(){
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window{
            
            let destinationVC = UserOnboardingViewController(collectionViewLayout: layout)
            window.rootViewController = destinationVC
            window.makeKeyAndVisible()
        }
    }
    
}

