//
//  AttendanceServices.swift
//  companion
//
//  Created by Yves Songolo on 9/13/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import KeychainSwift
struct AttendanceServices{
    /// method to create a new attendance
    static func create(_ attendance: Attendance, completion: @escaping (Attendance?) ->()){
        
        post(attendance, completion: { (att, error) in
            
            if let attendance = att{
                return completion(attendance)
            }
            else{
                return completion(nil)
            }
        })
    }

    /// method to retrieve all attendance
    static func show(completion: @escaping([Attendance]?)->()){
        
        NetworkManager.network(.attendance, .get) { (attendance, error) in
            guard let att = attendance as? [Attendance] else {return completion (nil)}
            print("Attendance: \(att)")
            
            return completion(att)
        }
    }
    /// method to fetch the last attendance
    static func fetchLastAttendance(id: String? = nil, completion: @escaping(Attendance)->()){
        var attendanceId = String()
        if let savedId = UserDefaults.standard.value(forKey: Constants.attendanceId) as? Int{
            attendanceId = String(savedId)
        }
        
         NetworkManager.network(.attendance, .get, id ?? attendanceId) { (attendance, error) in
            if let attendance = attendance as? Attendance {
                return completion(attendance)
            }
        }
    }
    
    static func delete(id: String, completion: @escaping (Attendance)->()){
        NetworkManager.network(.attendance, .delete, id) { (attendance, error) in
            return completion(attendance as! Attendance)
        }
    }
    
    static func update(attendance: Attendance,completion: @escaping (Attendance)->()){
        
        NetworkManager.network(.attendance, .update, String(attendance.id!), params: attendance.toDictionary()) { (attendance, error) in
            return completion(attendance as! Attendance)
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
            
            let todayAttendance = attendances.filter({$0.event_in == Date().toString()})
            
            return todayAttendance.isEmpty ? completion (nil) : completion(todayAttendance.first)
            
        }
    }
    
    /// method to save the last date of attendance on userdefault
    static func markAttendance(){
        UserDefaults.standard.set(Date().toString(), forKey: Constants.savedAttendance)
    }
    static func isTodayAttendanceDone() -> Bool{
        
        if let date = UserDefaults.standard.value(forKey: Constants.savedAttendance) as? String{
            if date == Date().toString(){
                return true
            }else{
                return false
            }
        }
        else{
           return false
        }
    }
    
    static func markCheckoutDone(){
        UserDefaults.standard.set(Date().toString(), forKey: Constants.checkoutDate)
    }
    
    /// check if checkout attendance have been made already
    static func isTodayAttendanceCheckOut() -> Bool{
        
        if let date = UserDefaults.standard.value(forKey: Constants.checkoutDate) as? String{
            if date == Date().toString(){
                return true
            }else{
                return false
            }
        }
        else{
            return false
        }
    }
    
}






