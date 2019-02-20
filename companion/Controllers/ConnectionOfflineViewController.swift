//
//  ConnectionOfflineViewController.swift
//  companion
//
//  Created by Uchenna  Aguocha on 2/12/19.
//  Copyright © 2019 Yves Songolo. All rights reserved.
//

import Foundation
import UIKit

class ConnectionOfflineViewController: UIViewController {
    
    // MARK: - Properties
    
    let network = NetworkStatusManager.shared
    
    // MARK: - UI Components
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Could not connect. Please check your connection and try again."
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Medium", size: 17)
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: - View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MakeSchoolDesignColor.faintBlue
        
        setupAutoLayout()
        network.reachability.whenReachable = { reachability in
            
        }
    }
    
    // MARK: - Methods
    
    fileprivate func setupAutoLayout() {
        statusLabel.centerAnchor(centerX: view.centerXAnchor, centerY: view.centerYAnchor, width: 120, height: 60)
    }
}
