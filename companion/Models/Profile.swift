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
    var dribbble_handle: String?
    var user_id: Int?
    var facebook_handle: String?
    var linkedin_handle: String?
    var resume_document_url: String?
    var publication_description: String?
    var public_view: Bool?
    var employment_status: String?
}
