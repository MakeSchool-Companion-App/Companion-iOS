//
//  NetworkManager.swift
//  companion
//
//  Created by Yves Songolo on 9/13/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation

struct NetworkManager {
   
    static func network(_ path: Path, _ httpMethod: HttpMethod, _ httpBody: Data? = nil, credentail: [String:String]? = nil, params: [String:Any]? = nil,completion: @escaping (Any?, Error?)->()){
        // 1.  based link
        var links = "https://make-school-companion.herokuapp.com/"
        
        // 2.  path
        links += path.rawValue
        
       
        
        //4. params
        if let params = params{
            let beacon = params["beacon_id"] as! String
            let time = params["event_time"] as! String
            let event = params["event"] as! String
            links += "?beacon_id=\(beacon)&event_time=\(time)&event=\(event)"
        }
        
        let url = URL(string: links)
        
        var request = URLRequest(url: url!)
        
        // 5. header
        if path.rawValue == Path.attendance.rawValue{
            request.setValue("Token token=\(User.current?.token ?? "")", forHTTPHeaderField: "Authorization")
        }
        
        if path.rawValue == Path.user.rawValue{
            request.allHTTPHeaderFields = credentail!
        }
        
        // 6. http method
        request.httpMethod = httpMethod.rawValue
        
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, res, err) in
            guard let data = data else {return completion(nil,err)}
            
            
            let response = res as! HTTPURLResponse
            print(response.statusCode)
            
//            print("This is the data as a string \(data.base64EncodedString())")
            
            switch path{
                
            case .attendance:
                switch httpMethod{
                case .get:
                    do{
                        
                        let attendances = try JSONDecoder().decode([Attendance].self, from: data)
                        
                        attendances.forEach({ (attendance) in
                            let date = attendance.created_at?.components(separatedBy: "T")
                            let time = date?.last?.components(separatedBy: ".")
                            attendance.event_time = (date?.first)!
                            attendance.checkInTime = time?.first!
                        })
                        
                        completion(attendances,nil)
                        
                    }catch{
                        completion(nil,nil)
                    }
                case .post: fallthrough
                case .update:
                    do{
                        let attanandace = try JSONDecoder().decode(Attendance.self, from: data)
                        completion(attanandace, nil)
                    }catch{
                        return completion(nil, nil)
                    }
                }
            case .user:
                switch httpMethod{
                    
                case .get: fallthrough
                case .post: fallthrough
                case .update:
                    do{
                        let user = try? JSONDecoder().decode(User.self, from: data)
                        completion(user, nil)
                        
                    } catch let error {
                        return completion(nil,error)
                        
                    }
                }
            case .dashboard:
                return completion(nil, nil)
            case .portfolio:
                return completion(nil, nil)
            }
        }
        task.resume()
    }
    
    static func fetchProfile(completion: @escaping ([Profile])->()){
        let link = "https://www.makeschool.com/portfolios.json"
        let url = URL(string: link)!
        let request = URLRequest(url: url)
        let session = URLSession.shared
        _ = session.dataTask(with: request) { (data, res, error) in
            guard let data = data else {return}
            
            do{
                let profiles = try JSONDecoder().decode([Profile].self, from: data)
                
                return completion(profiles)
            }
            catch{
                
            }
        }.resume()
    }
    
}

enum Path: String {
    case attendance = "attendances"
    case user = "registrations"
    case dashboard = "dashboard"
    case portfolio = "portfolio"
}


enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case update = "UPDATE"
}
enum HttpBody {
    case user
    case attendance
}


