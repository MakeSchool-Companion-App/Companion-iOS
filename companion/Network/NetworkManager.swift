//
//  NetworkManager.swift
//  companion
//
//  Created by Yves Songolo on 9/13/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
struct NetworkManager{
    //var shared = NetworkManager()
    static func network(_ path: Path, _ httpMethod: HttpMethod, _ httpBody: Data? = nil, completion: @escaping (Any?, Error?)->()){
    // 1.  based link
        var links = "https://make-school-companion.herokuapp.com/"
    
    // 2.  path
       links += path.rawValue
        let url = URL(string: links)
        
        var request = URLRequest(url: url!)
    // 3  body
        if let httpBody = httpBody {
            request.httpBody = httpBody
        }
    // 4. header
        request.setValue(User.current.token, forHTTPHeaderField: "Authorization")
    // 5. http method
        request.httpMethod = httpMethod.rawValue
        
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, _, err) in
            guard let data = data else {return completion(nil,err)}
            
            let res =  String(data: data, encoding: .utf8)
            print(res)
            
            switch path{
                
            case .attendance:
                switch httpMethod{
                case .get:
                    let attanandaces = try! JSONDecoder().decode([Attendance].self, from: data)
                        completion(attanandaces,nil)
                case .post:
                    let attanandace = try! JSONDecoder().decode(Attendance.self, from: data)
                        completion(attanandace, nil)
                case .update:
                    let attanandace = try! JSONDecoder().decode(Attendance.self, from: data)
                    completion(attanandace, nil)
                }
            case .user:
                switch httpMethod{
                    
                case .get: fallthrough
                case .post: fallthrough
                case .update:
                    do{
                    let user = try JSONDecoder().decode(User.self, from: data)
                        completion(user, nil)
                    }catch{
                       return completion(nil,nil)
                    }
                }
            }
        }
        task.resume()
    }
   
}

enum Path: String{
    case attendance = "attendances"
    case user = "registrations"
}
enum HttpMethod: String{
    case get = "GET"
    case post = "POST"
    case update = "UPDATE"
}
enum HttpBody{
    case user
    case attendance
}


