//
//  Attendance.swift
//  companion
//
//  Created by Yves Songolo on 9/13/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
class Attendance: Codable{
    var event_time: String
    var event: String
    var beacon_id: String
    var user_id: Int?
    var id: Int?
    
    init(_ event_time: String, event: EventType, beaconId: String){
        self.event_time = event_time
        self.beacon_id = beaconId
        self.event = event.rawValue
        self.user_id = Int(User.current.user_id!)
    }
    func toBody() -> Data{
        return try! JSONEncoder().encode(self)
    }
    func toDictionary()->[String: Any]{
        return ["event_time":event_time,"beacon_id":beacon_id,"event":event]
    }
}

enum EventType: String{
    case onEntry = "Entry"
    case onExit = "Exit"
}
