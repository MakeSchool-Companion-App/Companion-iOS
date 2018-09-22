//
//  UserServices.swift
//  companion
//
//  Created by Yves Songolo on 9/19/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
struct UserServices{
    
    func show( completion: @escaping (User?)->()){
        
    }
    /// method to login user with email and password
    static func login(email: String, password: String, completion: @escaping(Any)->()){
        
        let json = ["email":email,
                    "password":password]
        let data = try! JSONEncoder().encode(json)
        
        NetworkManager.network(.user, .post, data) { (user, error) in
            guard let user = user as? User else { return completion(error!)}
            
            User.setCurrent(user, writeToUserDefaults: true)
            return completion(user)
        }
    }
    
}
