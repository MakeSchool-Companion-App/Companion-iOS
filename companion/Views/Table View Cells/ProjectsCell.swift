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
    
    var projectsCollectionView: UICollectionView?
    
    
    // MARK: - Initializers
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollectionView()
        setupAutoLayout()
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        projectsCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 300, height: 300), collectionViewLayout: flowLayout)
        projectsCollectionView?.backgroundColor = MakeSchoolDesignColor.darkBlue
        projectsCollectionView?.register(ProjectsCollectionCell.self, forCellWithReuseIdentifier: ProjectsCollectionCell.projectsCollectionCellId)
    }
    
    private func setupAutoLayout() {
        
        contentView.addSubview(projectsCollectionView ?? UICollectionView())
        
        projectsCollectionView?.anchor(
            top: contentView.topAnchor,
            right: contentView.rightAnchor,
            bottom: contentView.bottomAnchor,
            left: contentView.leftAnchor)
        
    }
    
    // Credit goes to Ash Furrow
    func setCollectionViewDataSourceDelegate
        <D: UICollectionViewDataSource & UICollectionViewDelegate>
        (dataSourceDelegate: D, forRow row: Int) {
        projectsCollectionView?.delegate = dataSourceDelegate
        projectsCollectionView?.dataSource = dataSourceDelegate
        projectsCollectionView?.tag = row
        projectsCollectionView?.reloadData()
    }
}
