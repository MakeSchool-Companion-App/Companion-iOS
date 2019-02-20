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

        let credential = ["email": email, "password": password]
        
        NetworkManager.network(.user, .post, credentail: credential) { (user, error) in
            
            guard let user = user as? User else { return completion(error) }
            User.setCurrent(user, writeToUserDefaults: true)
            
            // Stops the  activity indicator when the user object has been fetched
            DispatchQueue.main.async {
                Constants.indicatorView.stopAnimating()
            }
            
            return completion(user)
        }
    }
}
