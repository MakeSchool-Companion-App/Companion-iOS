//
//  Profile.swift
//  companion
//
//  Created by Yves Songolo on 10/19/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation

struct Profile: Codable {
    let id : Int
    let first_name: String
    let last_name: String
    let slug: String
    var github_handle: String?
    var professional_title: String?
    var about_short_description: String?
    var about_description: String?
    var profile_img_url: String?
    var contact_description: String?
    var twitter_handle: String?
    var email: String?
    var instagram_handle: String?
    var dribbble_handle: String
    var user_id: Int?
    var facebook_handle: String?
    var linkedin_handle: String?
    var resume_document_url: String?
    var publication_description: String?
    var public_view: Bool?
    var employment_status: String?
    
    
    private static var _current: Profile?
    
    static var current: Profile?{
        if let currentProfile = _current {
            return currentProfile
        }
        else{
            guard let data = UserDefaults.standard.value(forKey: Constants.currentStudentProfile) as? Data,
            let profile = try? JSONDecoder().decode(Profile.self, from: data) else
            {return nil}
            
            return profile
        }
    }
    
    /// Set the current user profile
    static func setCurrentProfile(for profile: Profile, writeToUserDefaults: Bool = false){
        
        if writeToUserDefaults{
            if let data = try? JSONEncoder().encode(profile){
                UserDefaults.standard.set(data, forKey: Constants.currentStudentProfile)
            }
        }
        _current = profile
    }
}
