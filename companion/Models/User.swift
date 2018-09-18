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
    var user_id: String
    var token: String?
    var image_url: String?
    
   
    static var current: User!
}

