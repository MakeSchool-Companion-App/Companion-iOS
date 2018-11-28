//
//  ProjectsCollectionViewModel.swift
//  companion
//
//  Created by Uchenna  Aguocha on 11/27/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation

class ProjectsViewModel {
    
    // MARK: Properties
    
    private var projects = [Project]()
    
    // MARK: Methods
    
    // Fetch user's projects using a their slug
    func fetchUsersProjects(slug: String, completion: (() -> Void)?) {
        DispatchQueue.global().async {
            ProjectServices.show(slug: slug) { (projects) in
                if let projects = projects as? [Project] {
                    self.projects = projects
                    completion?()
                }
            }
        }
    }
    
    func cellViewModel(index: Int) -> ProjectViewModel? {
        let projectCollectionViewCellModel = ProjectViewModel(project: self.projects[index])
        return projectCollectionViewCellModel
    }
    
    var count: Int {
        return projects.count
    }
}












