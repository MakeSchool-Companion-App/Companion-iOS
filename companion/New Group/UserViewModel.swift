//
//  UserViewModel.swift
//  companion
//
//  Created by Uchenna  Aguocha on 11/23/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation

struct UserViewModel {
    
    // MARK: - Properties
    
    private let user = User.current
    
    var fullname: String {
        if let firstname = user?.first_name,
           let lastname = user?.last_name {
            return "\(firstname) \(lastname)"
        }
        return " "
    }
    
    var token: String {
        return user?.token ?? ""
    }
    
    var userId: String? {
        if let userId = user?.user_id {
            return userId
        }
        return ""
    }
    
    var imageUrl: String {
        return user?.image_url ?? ""
    }
    
    var email: String {
        return user?.email ?? ""
    }
}
