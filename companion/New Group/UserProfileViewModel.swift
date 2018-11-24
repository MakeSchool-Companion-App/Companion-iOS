//
//  UserProfileViewModel.swift
//  companion
//
//  Created by Uchenna  Aguocha on 11/23/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation

struct UserProfileViewModel {
    
    // MARK: Properties
    
    private let profile: Profile
    
    var profileId: Int {
        return profile.id
    }
    
    var fullname: String {
        return "\(profile.first_name) \(profile.last_name)"
    }
    
    var firstName: String {
        return profile.first_name
    }
    
    var lastName: String {
        return profile.last_name
    }
    
    var gitHubHandle: String? {
        if let handle = profile.github_handle {
            return handle
        }
        return ""
    }
    
    var professionalTitle: String {
        return profile.professional_title ?? " "
    }
    
    var aboutDescription: String {
        return profile.about_description ?? ""
    }
    
    var aboutShortDescription: String {
        return profile.about_short_description ?? ""
    }
    
    var profileImageURL: String {
        return profile.profile_img_url ?? ""
    }
//    let id : Int
//    let first_name: String
//    let last_name: String
//    let slug: String
//    var github_handle: String?
//    var professional_title: String?
//    var about_short_description: String?
//    var about_description: String?
//    var profile_img_url: String?
//    var contact_description: String?
//    var twitter_handle: String?
//    var email: String?
//    var instagram_handle: String?
//    var dribbble_handle: String?
//    var user_id: Int?
//    var facebook_handle: String?
//    var linkedin_handle: String?
//    var resume_document_url: String?
//    var publication_description: String?
//    var public_view: Bool?
//    var employment_status: String?
}
