//
//  AttendanceViewModel.swift
//  companion
//
//  Created by Uchenna  Aguocha on 11/27/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation


struct AttendanceViewModel {
    
    // MARK: Stored Properties
    
    private let attendance: Attendance
    
    // MARK: Initializers
    
    init(attendance: Attendance) {
        self.attendance = attendance
    }
    
    // MARK: Computed Properties
    
    var event: String {
        return attendance.event ?? " "
    }
    
    var beaconId: String {
        return attendance.beacon_id ?? " "
    }
    
    var userId: Int {
        return attendance.user_id ?? 0
    }
    
    var id: Int {
        return attendance.id ?? 0
    }
    
    var createdAt: String {
        return attendance.created_at ?? " "
    }
    
    var checkInDate: String {
        return attendance.checkInDate ?? ""
    }
    
    var checkInTime: String {
        return attendance.checkInTime ?? ""
    }
    
    var checkOutDate: String {
        return attendance.checkOutDate ?? ""
    }
    
    var checkOutTime: String {
        return attendance.checkOutTime ?? ""
    }
    
    var eventIn: String {
        return attendance.event_in ?? ""
    }
    
    var eventOut: String {
        return attendance.event_out ?? ""
    }
  
}
