//
//  Attendance.swift
//  companion
//
//  Created by Yves Songolo on 9/13/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation

class Attendance: Codable {
    
    var event: String
    var beacon_id: String?
    var user_id: Int?
    var id: Int?
    var created_at: String?
    var checkInTime: String?
    var checkOutTime: String?
    var event_in: String
    var event_out: String?
    
    init( event: EventType, beaconId: String?, event_in: String, event_out: String, id: Int, user_id: Int) {
      
        self.beacon_id = beaconId ?? "No beacon id"
        self.event = event.rawValue
        self.user_id = Int(User.current?.user_id! ?? "0")
        self.event_in = event_in
        self.event_out = event_out
        self.id = id
        self.user_id = user_id
    }
    
    func toBody() -> Data {
        return try! JSONEncoder().encode(self)
    }
    func toDictionary()->[String: Any]{
        return ["event_in":event_in,"beacon_id":beacon_id ?? "","event":event, "event_out":event_out ?? "none"]
    }
    
    enum CodingKeys: String,CodingKey{
        case event, beacon_id, user_id, event_in, event_out, id
    }
   
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let event_type = try container.decode(String.self, forKey: .event)
        var event = EventType.onEntry
       
        switch event_type{
            
        case "OnEntry": event = EventType.onEntry
        case "OnExit": event = EventType.onExit
        default: break
        }
       
        let beacon_id = try  container.decode(Int?.self, forKey: .beacon_id)
        let id = try container.decode(Int.self, forKey: .id)
        let user_id = try container.decode(Int.self, forKey: .user_id)
        let event_in = try container.decode(String.self, forKey: .event_in)
        let event_out = try container.decodeIfPresent(String.self, forKey: .event_out)
        
        let timeIn = event_in.components(separatedBy: "+")
        let timeOut = event_out?.components(separatedBy: "+")
        let checkInDate = timeIn[0]
        let checkInTime = timeIn[1]
        self.init(event: event, beaconId: String(beacon_id!), event_in: checkInDate, event_out: event_out ?? "", id: id, user_id: user_id)
        
       
        if let checkOutTime = timeOut?[1]{
             self.event_out = timeOut![0]
            self.checkOutTime = checkOutTime
          
        }
        self.checkInTime = checkInTime
      
        
       
    }
    
    
}

enum EventType: String{
    case onEntry = "Entry"
    case onExit = "Exit"
}

