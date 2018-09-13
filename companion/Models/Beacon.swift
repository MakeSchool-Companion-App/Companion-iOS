//
//  File.swift
//  companion
//
//  Created by Yves Songolo on 9/13/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
class Beacon: Decodable{
    var uuid: String
    var minor: String
    var major: String
    
    init(_ uuid: String, _ minor: String, _ major: String){
        self.uuid = uuid
        self.major = major
        self.minor = minor
    }
}
