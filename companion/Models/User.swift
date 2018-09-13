//
//  User.swift
//  companion
//
//  Created by Yves Songolo on 9/13/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
class User: Decodable{
    var firstName: String
    var lastName: String
    var id: String
    var token: String
    var attendance: [Attendance]
}
