//
//  ProjectServices.swift
//  companion
//
//  Created by Yves Songolo on 11/6/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation

struct ProjectServices {
    
    /// Fetche and decode projects from the user from the make school's website
    static func show(slug: String, completion: @escaping(Any?)->()){
        
     let link = "https://www.makeschool.com/portfolios/\(slug)/projects.json"
        let url = URL(string: link)!
        do{
        let data = try Data(contentsOf: url)
            let projects = try JSONDecoder().decode([Project].self, from: data)
            return completion(projects)
        }
        catch {
            return completion(nil)
        }
    }
}
