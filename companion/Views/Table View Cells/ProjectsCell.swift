//
//  ProjectsCell.swift
//  companion
//
//  Created by Uchenna  Aguocha on 10/17/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit

class ProjectsCell: UITableViewCell {
    
    // MARK: - Properties
    static var projectsCellId = "projectsCellId"
    
    
    // MARK: - UI Elements
    
    lazy var projectsCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView()
        collectionView.collectionViewLayout = layout
        collectionView.register(ProjectsCollectionCell.self, forCellWithReuseIdentifier: ProjectsCollectionCell.projectsCollectionCellId)
        
        return collectionView
    }()
    
    
    // MARK: - Initializers
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupAutoLayout() {
        
        contentView.addSubview(projectsCollectionView)
        
        projectsCollectionView.anchor(
            top: contentView.topAnchor,
            right: contentView.rightAnchor,
            bottom: contentView.bottomAnchor,
            left: contentView.leftAnchor)
        
    }
    
    // Credit goes to Ash Furrow
    func setCollectionViewDataSourceDelegate
        <D: UICollectionViewDataSource & UICollectionViewDelegate>
        (dataSourceDelegate: D, forRow row: Int) {
        
        projectsCollectionView.delegate = dataSourceDelegate
        projectsCollectionView.dataSource = dataSourceDelegate
        projectsCollectionView.tag = row
        projectsCollectionView.reloadData()
    }
}
