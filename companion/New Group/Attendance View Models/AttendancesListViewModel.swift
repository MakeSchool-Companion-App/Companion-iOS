//
//  AttendancesViewModel.swift
//  companion
//
//  Created by Uchenna  Aguocha on 11/27/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation

class AttendancesListViewModel {
    
    
    private (set) var attendancesViewModel = [AttendanceViewModel]()
    private var completion: () -> Void = { }
    
    init(completion: @escaping () -> Void) {
        self.completion = completion
        fetchAttendances()
    }
    
    private func fetchAttendances() {
        AttendanceServices.show { (attendances) in
            self.attendancesViewModel = attendances.map(AttendanceViewModel.init)
            self.completion()
        }
    }
    
    func attendanceAt(index: Int) -> AttendanceViewModel {
        return attendancesViewModel[index]
    }
    
    
//    // MARK: Type Aliases
//
//    typealias CompletionHandler = () -> Void
//    typealias AttendanceCompletionHandler = (Attendance) -> Void
//    typealias ExistingAttendanceHandler = (Bool) -> Void
//
//    // MARK: Stored Properties
//
//    private var attendances = [Attendance]()
//
//    // MARK: Computed Properties
//
//    var count: Int {
//        return attendances.count
//    }
//
//    // MARK: Methods
//
//
//    func fetchAttendances(completion: CompletionHandler?) {
//        // Fetch every attendance from Companion API
//        AttendanceServices.show { (attendances) in
//            guard let attendances = attendances else { return }
//            self.attendances = attendances
//
//            completion?()
//        }
//    }
//
//
//    func createAttendance(with attendance: Attendance, completion: AttendanceCompletionHandler?) {
//        // Create and post an attendance
//        AttendanceServices.create(attendance) { (newAttendance) in
//            guard let newAttendance = newAttendance else { return }
//            completion?(newAttendance)
//        }
//    }
//
//    func fetchTheLastAttendance(id: String?, completion: AttendanceCompletionHandler?) {
//        AttendanceServices.fetchLastAttendance(id: id) { (attendance) in
//            completion?(attendance)
//        }
//    }
//
//    func deleteAttendance(id: String, completion: @escaping AttendanceCompletionHandler) {
//        AttendanceServices.delete(id: id) { (attendance) in
//            completion(attendance)
//        }
//    }
//
//    func updateAttendance(attendance: Attendance, completion: @escaping AttendanceCompletionHandler) {
//        AttendanceServices.update(attendance: attendance) { (attendance) in
//            completion(attendance)
//        }
//    }
//
//    func doesAttendanceExist(completion: @escaping (Bool) -> ()) {
//        AttendanceServices.isAttendanceExist(completion: completion)
//    }
//
//
//    func saveAttendance(completion: CompletionHandler?) {
//        // Save the most recent attendance in User Defaults
//        AttendanceServices.markAttendance()
//        completion?()
//    }
//
//    func doesTodaysAttendanceExist(completion: ExistingAttendanceHandler?) {
//        let found = AttendanceServices.isTodayAttendanceDone()
//        completion?(found)
//    }
//
//    func saveCheckoutDate(completion: CompletionHandler?) {
//        AttendanceServices.markCheckoutDone()
//        completion?()
//    }
//
//
//    func doesCheckoutExist(completion: ExistingAttendanceHandler?) {
//        let found = AttendanceServices.isTodayAttendanceCheckOut()
//        completion?(found)
//    }
//
//    func cellViewModel(index: Int) -> AttendanceViewModel? {
//        let attendanceViewModel = AttendanceViewModel(attendance: attendances[index])
//        return attendanceViewModel
//    }
}

