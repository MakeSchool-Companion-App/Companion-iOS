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


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static let shared: AppDelegate = AppDelegate()
    
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
        
        window = UIWindow()
//        window?.makeKeyAndVisible()

//        let loginController = LoginController()
//        window?.rootViewController = loginController
//        let mainTabBarController = MainTabBarController()
//        window?.rootViewController = mainTabBarController
        
        configureInitialRootViewController(for: window)
        
        beaconManager.startMonitoring()
        GeoFenceServices.startMonitoringMakeschool { (started) in
            if started == true{
                self.locationManager.delegate = self
            }
        }
        
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (requestAuth, error) in
            print("AppDelegate: Testing Request Authorization")
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        self.locationManager.delegate = self
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        }
    }

extension AppDelegate: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        let identifier = region.identifier
        if identifier == Constant.makeSchoolRegionId {
            let attendance = Attendance.init(Date().toString(), event: .onEntry, beaconId: "")
            AttendanceServices.create(attendance) { (att) in
                if let checkInAttendance = att{
                    UserDefaults.standard.set(checkInAttendance.id, forKey: "attendance_id")
                    UserDefaults.standard.set(checkInAttendance.event_time, forKey: "event_time")
                    /// local notification
                    self.attendanceNotification(attendance: checkInAttendance)
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if region.identifier == Constant.makeSchoolRegionId {
            
            if let eventTime = UserDefaults.standard.value(forKey: "event_time") as? String {
                
                if eventTime == Date().toString() {
                    guard let attendanceId = UserDefaults.standard.value(forKey: "attendance_id") as? String else { return }
                    
                    // Fetch a list of attendance from the Companion API
                    AttendanceServices.show { (attendance) in
                        // Get today's attendance (first element in the array)
                        let attendance = attendance?.filter { $0.id == Int(attendanceId) }
                        let todaysAttendance = attendance?.first
                            /// adding the clock out time on the attendance model
                            /// clean the user default
                    }
                }
            }
        }
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func attendanceNotification(attendance: Attendance) {
        
        // The notification content
        let content = UNMutableNotificationContent()
        
        // Adding title, subtitle, body and badge
        content.title = "Companion"
        content.subtitle = "Check In"
        content.body = "You entered Make School at \(attendance.event_time)."
        content.badge = 1
        
        // Triggering the notification
        // Once a person steps inside the building
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        
        // Getting the notification request
        let request = UNNotificationRequest(identifier: Constant.attendanceNotificationId, content: content, trigger: trigger)
        
        center.add(request, withCompletionHandler: nil)
        
    }
    
}

extension AppDelegate {
    
    func configureInitialRootViewController(for window: UIWindow?) {
        let defualts = UserDefaults.standard
        let initialViewController: UIViewController
        
       
        if let _ = User.current as? User,
           let userData = defualts.object(forKey: Constant.current) as? Data,
           let user = try? JSONDecoder().decode(User.self, from: userData) {
            
            User.setCurrent(user)
            initialViewController = MainTabBarController()
        } else {
            initialViewController = LoginController()
        }
        
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
    
    }
    
}
