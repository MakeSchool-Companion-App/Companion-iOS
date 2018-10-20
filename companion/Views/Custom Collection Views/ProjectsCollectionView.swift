//
//  ProjectsCollectionView.swift
//  companion
//
//  Created by Uchenna  Aguocha on 10/19/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import UIKit

class ProjectsCollectionView: UICollectionView {
    
    // MARK: - Properties
    var name = "ProjectsCollectionView"
    
    // MARK: - UI Elements
    
    // MARK: - Initializers
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupCollectionViewCell() {
        self.register(ProjectsCollectionCell.self, forCellWithReuseIdentifier: ProjectsCollectionCell.projectsCollectionCellId)
        
    }
    
    
    
    
}
