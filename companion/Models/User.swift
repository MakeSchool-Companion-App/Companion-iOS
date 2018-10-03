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
    
    static var current: User {
        if let currentUser = _current  {
            return currentUser
        }
        else{
            let data =   UserDefaults.standard.value(forKey: Constant.current) as? Data
            let user = try! JSONDecoder().decode(User.self, from: data!)
            return user
        }
        
    }
    
    // MARK: - Class Methods
    
    static func setCurrent(_ user: User, writeToUserDefaults: Bool = false) {
        if writeToUserDefaults {
            if let data = try? JSONEncoder().encode(user) {
                UserDefaults.standard.set(data, forKey: Constant.current)
            }
        }
        _current = user
    }
}

