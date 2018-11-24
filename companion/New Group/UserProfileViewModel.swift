//
//  UserProfileViewModel.swift
//  companion
//
//  Created by Uchenna  Aguocha on 11/24/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation

typealias LoginSuccess = (Bool) -> Void

struct UserViewModel {
    
    // MARK: Properties
    
    private let user = User.current
    
    var fullname: String {
        return "\(user?.first_name ?? "") \(user?.last_name ?? "")"
    }
    
    var firstName: String {
        return user?.first_name ?? ""
    }
    
    var lastName: String {
        return user?.last_name ?? ""
    }
    
    var imageUrl: String {
        return user?.image_url ?? ""
    }
    
    var email: String {
        return user?.email ?? ""
    }
    
    
    func login(email: String, password: String, completionHandler: @escaping LoginSuccess) {
        
        UserServices.login(email: email, password: password) { (user) in
            if let user = user as? User {
                User.setCurrent(user, writeToUserDefaults: true)
                completionHandler(true)
            } else {
                completionHandler(false)
            }
            
        }
    }
    
}
