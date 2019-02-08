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

        
        configureInitialRootViewController()
        //locationManager.delegate = self
        //beaconManager.startMonitoring()
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     //self.locationManager.delegate = self
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
       // self.locationManager.delegate = self
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     //self.locationManager.delegate = self
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
     //self.locationManager.delegate = self
    }
    }

extension AppDelegate: CLLocationManagerDelegate{

    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {

    }
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {

    }
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print(region.identifier)
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
            content.body = "You entered Make School at \(attendance.checkInTime ?? " ")"
            content.badge = 1
        case "Exit":
            content.title = "Companion"
            content.subtitle = "Check Out"
            content.body = "You left Make School at \(attendance.checkOutTime ?? " ")"
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
    
    func configureInitialRootViewController() {
        
        let defualts = UserDefaults.standard
        
        if let _ = User.current,
           let userData = defualts.object(forKey: Constants.current) as? Data,
           let user = try? JSONDecoder().decode(User.self, from: userData) {
            
            User.setCurrent(user)
            showHomePage()
        } else {
            
            showOnboardingPage()
        }
    }
    
    /// Renders the onboarding page
    private func showOnboardingPage(){
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window{
            
            let destinationVC = UserOnboardingViewController(collectionViewLayout: layout)
            window.rootViewController = destinationVC
            window.makeKeyAndVisible()
        }
    }
    
    /// Renders the homepage
    private func showHomePage(){
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let destinationVC = MainTabBarController()
        window?.rootViewController = destinationVC
        window?.makeKeyAndVisible()
    
    }
    
    /// Shows the Login page
    func showLoginPage(){
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let destinationVC = LoginController()
        window?.rootViewController = destinationVC
        window?.makeKeyAndVisible()
    }
    
}

