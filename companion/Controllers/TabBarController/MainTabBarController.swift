//
//  MainTabBarController.swift
//  companion
//
//  Created by Uchenna  Aguocha on 9/28/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMainTabBar()
    }
    
    // MARK: - Methods
    
    private func setupMainTabBar() {
        // Once it's called, this function will setup the tab bar.
        
        // Attendance
        let attendanceNavController = createNavigationController(
            navTitle: "Attendance",
            tabBarTitle: "Attendance",
            unselectedImageName: UIImage(named: "unselectedClock"),
            selectedImageName: UIImage(named: "unselectedClock"),
            rootViewController: AttendanceController())
        
        // Student Dashboard
        let studentDashboardNavController = createNavigationController(
            navTitle: "Dashboard",
            tabBarTitle: "Dashboard",
            unselectedImageName: UIImage(named: "profile_unselected"),
            selectedImageName: UIImage(named: "profile_selected"),
            rootViewController: StudentDashboardController())
        
        
        // Add each controller in the view controllers array
        viewControllers = [studentDashboardNavController, attendanceNavController]
        
        
        // modify tab bar item insets
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
        
    }
    
    
    private func createNavigationController(navTitle: String?, tabBarTitle: String?, unselectedImageName: UIImage?, selectedImageName: UIImage?, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        // This function will create and return a custom tabBar navigation controller
        
        
        let viewController = rootViewController
        viewController.navigationItem.title = navTitle
        
        
        // setup NavigationController with a rootViewController
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = tabBarTitle
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "AvenirNext-DemiBold", size: 20)!, NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController.navigationBar.barTintColor = MakeSchoolDesignColor.darkBlue
        
        
        // setup TabBarItemImage
        if let unselectedImageName = unselectedImageName, let selectedImageName = selectedImageName {
            
            navigationController.tabBarItem.image = unselectedImageName
            
            navigationController.tabBarItem.selectedImage = selectedImageName
            
        }
        
        tabBar.isTranslucent = false
        tabBar.barTintColor = MakeSchoolDesignColor.faintBlue
        tabBar.tintColor = MakeSchoolDesignColor.darkBlue
//        tabBar.unselectedItemTintColor = MakeSchoolDesignColor.grey
        return navigationController
    }
    
    
    
}
