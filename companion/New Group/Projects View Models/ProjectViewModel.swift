//
//  ProjectViewModel.swift
//  companion
//
//  Created by Uchenna  Aguocha on 11/27/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation

class ProjectViewModel {
    
    private let project: Project
    
    init(project: Project) {
        self.project = project
    }
    
    var name: String {
        return project.name
    }
    
    var technologies: String {
        return project.technologies
    }
    
    var imageUrl: String {
        return project.img_url
    }
    
    var writeupUrl: String {
        return project.writeup_url ?? ""
    }
    
    var githubUrl: String {
        return project.github_url ?? ""
    }
    
    var uri: String {
        return project.uri ?? ""
    }
    
    var id: Int {
        get {
            return project.id
        }
    }
    
    var description: String {
        return project.description ?? ""
    }
    
    
}
