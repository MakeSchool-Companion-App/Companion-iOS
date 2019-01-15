//
//  ProjectViewModel.swift
//  companion
//
//  Created by Uchenna  Aguocha on 11/27/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation

struct ProjectViewModel {
    
//    private let project: Project
    
    let id: Int
    let name: String
    let technologies: String
    let imageUrl: String
    let writeupUrl: String
    let githubUrl: String
    let uri: String
    let description: String
    
    init(project: Project) {
        self.id = project.id
        self.name = project.name
        self.technologies = project.technologies
        self.imageUrl = project.img_url
        self.writeupUrl = project.writeup_url ?? ""
        self.githubUrl = project.github_url ?? ""
        self.uri = project.uri ?? ""
        self.description = project.description ?? ""
    }
    
//    init(project: Project) {
//        self.project = project
//    }
//
//    var name: String {
//        return project.name
//    }
//
//    var technologies: String {
//        return project.technologies
//    }
//
//    var imageUrl: String {
//        return project.img_url
//    }
//
//    var writeupUrl: String {
//        return project.writeup_url ?? ""
//    }
//
//    var githubUrl: String {
//        return project.github_url ?? ""
//    }
//
//    var uri: String {
//        return project.uri ?? ""
//    }
//
//    var id: Int {
//        get {
//            return project.id
//        }
//    }
//
//    var description: String {
//        return project.description ?? ""
//    }
//
    
}
