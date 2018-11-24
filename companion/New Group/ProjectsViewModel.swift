//
//  ProjectsViewModels.swift
//  companion
//
//  Created by Uchenna  Aguocha on 11/24/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation

struct ProjectsViewModel {
    
    // MARK: Properties
    
    private var projects = [Project]()
     
    var numberOfProjects: Int {
        return projects.count
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    // MARK: Initializer
    
    init(project: Project) {
        
    }
    
    // MARK: Methods
    
    func name(for index: Int) -> String {
        return projects[index].name
    }
    
    func technologies(for index: Int) -> String {
        return projects[index].technologies
    }
    
    func imageUrl(for index: Int) -> String {
        return projects[index].img_url
    }
    
    func writeupUrl(for index: Int) -> String {
        return projects[index].writeup_url
    }
    
    func githubUrl(for index: Int) -> String {
        return projects[index].github_url
    }
    
    func uri(for index: Int) -> String {
        return projects[index].uri
    }
    
    func description(for index: Int) -> String {
        return projects[index].description
    }
    
    func id(for index: Int) -> Int {
        return projects[index].id
    }
    
    // Fetch user's projects using a their slug 
    func fetchUsersProjects(slug: String) {
        DispatchQueue.global().async {
            ProjectServices.show(slug: slug) { (projects) in
                if let projects = projects as? [Project] {
                    self.projects = projects
                }
            }
        }
        
    }
    
    
}
