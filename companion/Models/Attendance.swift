//
//  Attendance.swift
//  companion
//
//  Created by Yves Songolo on 9/13/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation

class Attendance: Codable {
    
    var event: String?
    var beacon_id: String?
    var user_id: Int?
    var id: Int?
    var created_at: String?
    var checkInDate: String?
    var checkInTime: String?
    var checkOutTime: String?
    var checkOutDate: String?
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
        return ["event_in":event_in ?? "","beacon_id":beacon_id ?? "","event":event ?? "Entry", "event_out":event_out ?? "00:00"]
    }
    
    enum CodingKeys: String,CodingKey{
        case event, beacon_id, user_id, event_in, event_out, id
    }
   
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let event_type = try container.decodeIfPresent(String.self, forKey: .event)
        var event = EventType.onEntry
       
        switch event_type{
        case "OnEntry": event = EventType.onEntry
        case "OnExit": event = EventType.onExit
        default: event = EventType.onEntry
        }
       
        let beacon_id = "makeschool"
        //try  container.decode(String?.self, forKey: .beacon_id)
        let id = try container.decode(Int.self, forKey: .id)
        let user_id = try container.decodeIfPresent(Int.self, forKey: .user_id)
        let event_in = try container.decodeIfPresent(String.self, forKey: .event_in)
        let event_out = try container.decodeIfPresent(String.self, forKey: .event_out)
        
        // Message for Yves [Fixed]: It crashed here because you were trying to access a value that didn't exist at index 1
        
        // Change this back to the original
//        let checkInDate = event_in?.convertToMonthDayYear.toString() ?? ""
//        let checkInTime = event_in?.timeToDate.timeToString() ?? "00:00"
        let checkInDate = event_in?.toDate()?.dayAndMonthStringFormat
        let checkInTime = event_in?.toDate()?.timeToStringFormat
        
        self.init(event: event, beaconId: beacon_id, event_in: event_in ?? "", event_out: event_out ?? "", id: id, user_id: user_id ?? 0)
        
        if event_out == Constants.eventOutEmptyFormatCheck{
           self.event_out = " "
            self.checkOutTime = " "
            self.checkOutDate = " "
        }
        else{
            // Change back to event_out?.timeToDate.timeToString()
            // Change baack to event_out?.convertToMonthDayYear.toString()
            if let checkOut = event_out?.toDate()?.timeToStringFormat {
                self.checkOutDate = event_out?.toDate()?.dayAndMonthStringFormat
                self.checkOutTime = checkOut
            }
        }
       
        self.checkInTime = checkInTime
        self.checkInDate = checkInDate
    }
    
    
}

enum EventType: String{
    case onEntry = "Entry"
    case onExit = "Exit"
}

