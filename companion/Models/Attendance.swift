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
    var event_in: String?
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
        return ["event_in":event_in,"beacon_id":beacon_id ?? "","event":event, "event_out":event_out ?? "00:00"]
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
       
        let beacon_id = "makeschool"//try  container.decode(String?.self, forKey: .beacon_id)
        let id = try container.decode(Int.self, forKey: .id)
        let user_id = try container.decode(Int.self, forKey: .user_id)
        let event_in = try container.decodeIfPresent(String.self, forKey: .event_in)
        let event_out = try container.decodeIfPresent(String.self, forKey: .event_out)
        
        // Message for Yves [Fixed]: It crashed here because you were trying to access a value that didn't exist at index 1
      
        let checkInDate = event_in?.convertToMonthDayYear.toString() ?? "00:00"
        let checkInTime = event_in?.timeToDate.timeToString() ?? "00:00"
        
        
        self.init(event: event, beaconId: beacon_id, event_in: checkInDate, event_out: event_out ?? "", id: id, user_id: user_id)
        
        if event_out == Constants.eventOutEmptyFormat{
           self.event_out = " "
            self.checkOutTime = " "
        }
        else{
            if let checkOutTime = event_out?.timeToDate.timeToString(){
                self.event_out = event_out?.convertToMonthDayYear.toString()
                self.checkOutTime = checkOutTime
            }
        }
       
        self.checkInTime = checkInTime
    }
    
    
}

enum EventType: String{
    case onEntry = "Entry"
    case onExit = "Exit"
}

