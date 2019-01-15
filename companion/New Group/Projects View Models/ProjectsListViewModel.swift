//
//  ProjectsCollectionViewModel.swift
//  companion
//
//  Created by Uchenna  Aguocha on 11/27/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation

class ProjectsListViewModel {
    
    // MARK: Properties
    private (set) var projectViewModels = [ProjectViewModel]()
    private var projects = [Project]()
    private var completion: () -> Void = { }
    
    
    init(completion: @escaping () -> Void) {
        self.completion = completion
        
    }
    // MARK: Methods
    
    // Fetch user's projects using a their slug
    func fetchUsersProjects(slug: String, completion: (() -> Void)?) {
        DispatchQueue.global().async {
            ProjectServices.show(slug: slug) { (projects) in
                self.projectViewModels = projects.map(ProjectViewModel.init))
                completion()
            }
        }
    }
    
    func cellViewModel(index: Int) -> ProjectViewModel? {
        let projectCollectionViewCellModel = ProjectViewModel(
        return projectCollectionViewCellModel
    }
    
    var count: Int {
        return projects.count
    }
}












