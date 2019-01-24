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
        Page(imageName: "makeschool", headerText: "Welcome to Companion", description: "Companion is a handy resource for Make School students."),
        Page(imageName: "ibeacon_onboarding", headerText: "Attendance Tracking", description: "Automatically get marked in and out of Make School based on your location."),
        Page(imageName: "portfolio_onboarding", headerText: "Student Portfolio", description: "All your projects viewable in one place, accessible at any time."),
        Page(imageName: "link_onboarding", headerText: "Usefull Links", description: "Find external links to the Student HandBook, ISAs on Vemo, Degree Path, and many more."),
        Page(imageName: "goals_onboarding", headerText: "Future Features", description: "Have any suggestions for future features? Post your ideas in the #makeschoolapp Slack channel.")
    ]
    
}
