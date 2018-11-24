//
//  UserProfileViewModel.swift
//  companion
//
//  Created by Uchenna  Aguocha on 11/24/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation

typealias ProfileCompletion = (Profile) -> Void

struct UserProfileViewModel {
    
    // MARK: Properties
    
    private var profile: Profile?
    private let currentUser = User.current
    
    
    var profileId: Int {
        return profile?.id ?? 0
    }
    
    var fullname: String {
        return "\(profile?.first_name ?? "") \(profile?.last_name ?? "")"
    }
    
    var firstName: String {
        return profile?.first_name ?? ""
    }
    
    var lastName: String {
        return profile?.last_name ?? ""
    }
    
    var slug: String {
        return profile?.slug ?? ""
    }
    
    var githubHandle: String {
        return profile?.github_handle ?? ""
    }
    
    var professionalTitle: String {
        return profile?.professional_title ?? ""
    }
    
    var aboutShortDescription: String {
        return profile?.about_short_description ?? ""
    }
    
    var aboutDescription: String {
        return profile?.about_description ?? ""
    }
    
    var profileImageUrl: String {
        return profile?.profile_img_url ?? ""
    }
    
    var contactDescription: String {
        return profile?.contact_description ?? ""
    }
    
    var twitterHandle: String {
        return profile?.twitter_handle ?? ""
    }
    
    var email: String {
        return profile?.email ?? ""
    }
    
    var instagramHandle: String {
        return profile?.instagram_handle ?? ""
    }
    
    var dribbbleHandle: String {
        return profile?.dribbble_handle ?? ""
    }
    
    var userId: Int {
        return profile?.user_id ?? 0
    }
    
    var facebookHandle: String {
        return profile?.facebook_handle ?? ""
    }
    
    var linkedinHandle: String {
        return profile?.linkedin_handle ?? ""
    }
    
    var resumeDocumentUrl: String {
        return profile?.resume_document_url ?? ""
    }
    
    var publicationDescription: String? {
        return profile?.publication_description ?? ""
    }
    
    var publicView: Bool? {
        return profile?.public_view
    }
    
    var employmentStatus: String {
        return profile?.employment_status ?? ""
    }
    
    func fetchUserProfile(completionHandler: @escaping ProfileCompletion) {
        ProfileService.show(user_id: Int(currentUser?.user_id ?? "0")) { (profile) in
            DispatchQueue.global().async {
                self.profile = profile
                completionHandler(profile)
            }
        }
    }
}
