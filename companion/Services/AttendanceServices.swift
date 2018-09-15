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
    static func create(completion: @escaping (Attendance?) ->()){
        
        isAttendanceExist { (exist) in
            switch exist{
            case true: completion(nil)
            case false:
                let attendance = Attendance(Date().toString(), Date().timeToString(), "")
                post(attendance, completion: { (att, error) in
                    guard error != nil else {return completion(att)}
                    return completion(nil)
                })
            }
        }
    }
    
    /// method to retrieve all attendance
    static func show(completion: @escaping([Attendance]?)->()){
        fetchAllAttendance { (attendance) in
            if let attendance = attendance{
                return completion(attendance)
            }
            else{
                return completion(nil)
            }
        }
    }
    /// method to check if today attendance was already made
    private static func isAttendanceExist(completion: @escaping (Bool)-> ()){
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
        
        NetworkManager.network(.postAttendance, .post, attendance.toBody()) { (att,err) in
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
        
        NetworkManager.network(.getAttendance, .get) { (attendance, err) in
            guard let value = attendance else {return completion(nil)}
            let attendance = value as! Attendance
            if attendance.date == Date().toString(){
               return completion(attendance)
            }
            else{
                return completion(nil)
            }
           
        }
    }
    /// method to fetch all attendances
    private static func fetchAllAttendance(completion: @escaping ([Attendance]?)->()){
        let attendance = Attendance(Date().toString(), Date().timeToString(), "")
        var att = [Attendance]()
        att.append(attendance)
        return completion(att)
    }
}






