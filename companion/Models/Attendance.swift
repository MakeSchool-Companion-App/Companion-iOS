//
//  Attendance.swift
//  companion
//
//  Created by Yves Songolo on 9/13/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
class Attendance: Codable{
    var date: String
    var entry: String
    var exit: String
    
    init(_ date: String, _ entry: String, _ exit: String){
        self.date = date
        self.entry = entry
        self.exit = exit
    }
    func toBody() -> Data{
        return try! JSONEncoder().encode(self)
    }
}
