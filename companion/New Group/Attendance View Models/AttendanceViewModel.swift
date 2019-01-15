//
//  AttendanceViewModel.swift
//  companion
//
//  Created by Uchenna  Aguocha on 11/27/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation


struct AttendanceViewModel {
    
    let id: Int
    let event: String
    let beaconId: String
    let userId: Int
    let createdAt: String
    let checkInDate: String
    let checkInTime: String
    let checkOutDate: String
    let checkOutTime: String
    let eventIn: String
    let eventOut: String
    
    
    init(attendance: Attendance) {
        self.id = attendance.id ?? 0
        self.event = attendance.event ?? ""
        self.beaconId = attendance.beacon_id ?? ""
        self.userId = attendance.user_id ?? 0
        self.createdAt = attendance.created_at ?? ""
        self.checkInDate = attendance.checkInDate ?? ""
        self.checkInTime = attendance.checkInTime ?? ""
        self.checkOutDate = attendance.checkOutDate ?? ""
        self.checkOutTime = attendance.checkOutTime ?? ""
        self.eventIn = attendance.event_in ?? ""
        self.eventOut = attendance.event_out ?? ""
    }
//    // MARK: Stored Properties
//
//    private let attendance: Attendance
//
//    // MARK: Initializers
//
//    init(attendance: Attendance) {
//        self.attendance = attendance
//    }
//
//    // MARK: Computed Properties
//
//    var event: String {
//        return attendance.event ?? " "
//    }
//
//    var beaconId: String {
//        return attendance.beacon_id ?? " "
//    }
//
//    var userId: Int {
//        return attendance.user_id ?? 0
//    }
//
//    var id: Int {
//        return attendance.id ?? 0
//    }
//
//    var createdAt: String {
//        return attendance.created_at ?? " "
//    }
//
//    var checkInDate: String {
//        return attendance.checkInDate ?? ""
//    }
//
//    var checkInTime: String {
//        return attendance.checkInTime ?? ""
//    }
//
//    var checkOutDate: String {
//        return attendance.checkOutDate ?? ""
//    }
//
//    var checkOutTime: String {
//        return attendance.checkOutTime ?? ""
//    }
//
//    var eventIn: String {
//        return attendance.event_in ?? ""
//    }
//
//    var eventOut: String {
//        return attendance.event_out ?? ""
//    }
//
}
