//
//  NetworkStatusManager.swift
//  companion
//
//  Created by Uchenna  Aguocha on 2/10/19.
//  Copyright © 2019 Yves Songolo. All rights reserved.
//

import Foundation
import Reachability

class NetworkStatusManager {
    
    // MARK:- Properties
    
    let reachability = Reachability()!
    static let shared = NetworkStatusManager()
    
    // MARK: - Initializer
    
    init() {
        setupReachabilityNotifier()
    }
    
    // MARK:- Methods
    
    private func setupReachabilityNotifier() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        
        do {
            try reachability.startNotifier()
        } catch let error {
            assertionFailure("Failed to set up reachability notifier. Error: \(error)")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        switch reachability.connection {
        case .wifi:
            print("Reachable via wifi")
        case .cellular:
            print("Reachable via cellular")
        case .none:
            print("Network not reachable")
        }
    }
    
    static func stopNotifier() {
        NetworkStatusManager.shared.reachability.stopNotifier()
    }
    
    typealias IsDeviceConnected = (_ isConnected: Bool) -> Void
    static func checkDevicesConnection(completion: @escaping IsDeviceConnected) {
        let connection = NetworkStatusManager.shared.reachability.connection
        if connection == .cellular || connection == .wifi {
            completion(true)
        } else {
            completion(false)
        }
    }
    
    
}

