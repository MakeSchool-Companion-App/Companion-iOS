//
//  Constant.swift
//  companion
//
//  Created by Yves Songolo on 9/25/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
struct Constants {
    
    static var current = "current"
    static var makeSchoolRegionId = "makeschool"
    static var attendanceNotificationId = "attendanceNotificationId"
    static let attendanceId = "attendance_id"
    static let eventId = "event_time"
    static let savedAttendance = "savedAttendance"
    static let lastAttendanceId = "lastAttendanceId"
    static let eventOutEmptyFormat = "000-00-00+00:00:00"
    static let eventOutEmptyFormatCheck = "000-00-00 00:00:00"
    static let checkoutDate = "checkoutDate"
    static let userOnboardingCellID = "onboardingCellId"
    
    static let pages = [
        Page(imageName: "makeschool", headerText: "Welcome to Companion", description: "Companion is the iOS platform created for Make School in sync with the web applications."),
        Page(imageName: "ibeacon_onboarding", headerText: "Attendance Tracking", description: "Automatically get marked in and out of the Make School HQ based on your location approximity."),
        Page(imageName: "portfolio", headerText: "Student Portfolio", description: "All your projects grouped within your grasp, accessible at all time."),
        Page(imageName: "link", headerText: "Usefull Links", description: "Find external links to the Student HandBook, ISAs on Venmo, Degree Path, and many more within the app."),
        Page(imageName: "schedule", headerText: "Future Features", description: "Upcoming versions will allow you to register for classes, view upcoming calendar meetings, general college announcements, and more.")
    ]
    
}
