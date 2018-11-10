//
//  ProfileService.swift
//  companion
//
//  Created by Yves Songolo on 10/19/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation

struct ProfileService{
    /// fetch all student profile
    static func index(completion: @escaping([Profile])->()){
        NetworkManager.fetchProfile { (profiles) in
            return completion(profiles)
        }
    }
    
    static func show(user_id: Int? = nil, completion: @escaping(Profile)->()){
        index { (profiles) in
            
//            let id = user_id ?? Int(User.current?.user_id! ?? "0")
            guard let id = user_id else {
                return
            }
            print("User Id: \(user_id)")
            
//            let profile = profiles.filter({$0.user_id == id}).first
            
            guard let profile = profiles.filter({ $0.user_id == id }).first else {
                return
            }

            
            return completion(profile)
        }
    }
}
