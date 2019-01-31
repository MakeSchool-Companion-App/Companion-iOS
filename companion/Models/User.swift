//
//  User.swift
//  companion
//
//  Created by Yves Songolo on 9/13/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
struct User: Codable{
    var first_name: String
    var last_name: String
    var user_id: String?
    var token: String?
    var image_url: String?
    var email: String
    
    private static var _current: User?
    
    static var current: User? {
        if let currentUser = _current  {
            return currentUser
        }
        else{
            guard let data = UserDefaults.standard.value(forKey: Constants.current) as? Data,
                
                let user = try? JSONDecoder().decode(User.self, from: data) else { return nil }
            return user
        }
        
    }
    
    // MARK: - Struct Methods
    
    static func setCurrent(_ user: User, writeToUserDefaults: Bool = false) {
        if writeToUserDefaults {
            if let data = try? JSONEncoder().encode(user) {
                UserDefaults.standard.set(data, forKey: Constants.current)
            }
        }
        _current = user
    }
}

