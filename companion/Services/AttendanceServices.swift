//
//  AttendanceServices.swift
//  companion
//
//  Created by Yves Songolo on 9/13/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
struct AttendanceServices{
    /// method to create a new attendance
    static func create(_ attendance: Attendance, completion: @escaping (Attendance?) ->()){
        
        isAttendanceExist {(exist) in
            switch exist{
            case true: completion(nil)
            case false:
                post(attendance, completion: { (att, error) in
                    guard error != nil else {return completion(att)}
                    return completion(nil)
                })
            }
        }
    }

    /// method to retrieve all attendance
    static func show(completion: @escaping([Attendance]?)->()){
        
        NetworkManager.network(.attendance, .get) { (attendance, error) in
            guard let att = attendance as? [Attendance] else {return completion (nil)}
            print("Attendance: \(att)")
            
            return completion(att)
        }
    }
    /// method to check if today attendance was already made
    static func isAttendanceExist(completion: @escaping (Bool)-> ()){
        getTodayAttendance { (attendance) in
            if attendance != nil{
                return completion(true)
            }
            else{
                return completion(false)
            }
        }
    }
    /// method to post attendance
    private static func post(_ attendance: Attendance, completion: @escaping(Attendance?, Error?)->()){
        NetworkManager.network(.attendance, .post, params: attendance.toDictionary()) { (att, err) in
            
             if let value = att {
                let attendance = value as! Attendance
                completion(attendance,nil)
            }
            else{
                completion(nil,err)
            }
        }
    }
    /// method to get today attendance
    private static func getTodayAttendance(completion: @escaping (Attendance?)->()){
        /// for test purpose
//        let attendance = Attendance(Date().toString(), Date().timeToString(), "")
//        return completion(attendance)
        
        NetworkManager.network(.attendance, .get) { (attendances, err) in
            guard let value = attendances else {return completion(nil)}
            let attendances = value as! [Attendance]
            
            let todayAttendance = attendances.filter({$0.event_time == Date().toString()})
            
            return todayAttendance.isEmpty ? completion (nil) : completion(todayAttendance.first)
            
        }
    }
    /// method to fetch all attendances
    private static func fetchAllAttendance(completion: @escaping ([Attendance]?)->()){
        
    }
}






