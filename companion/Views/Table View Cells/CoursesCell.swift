//
//  CoursesCell.swift
//  companion
//
//  Created by Uchenna  Aguocha on 10/17/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit


class CoursesCell: UITableViewCell {
    
    // MARK: - Properties
    static var coursesCellId = "coursesCellId"
    
    
    // MARK: - UI Elements
    
    var coursesCollectionView: UICollectionView?
    
    
    // MARK: - Initializers
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollectionView()
        setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//    }
    
    // MARK: - Methods
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        coursesCollectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        coursesCollectionView?.backgroundColor = MakeSchoolDesignColor.green
        coursesCollectionView?.register(CoursesCollectionCell.self, forCellWithReuseIdentifier: CoursesCollectionCell.coursesCollectionCellId)
    }
    
    private func setupAutoLayout() {
        
        contentView.addSubview(coursesCollectionView ?? UICollectionView())
        
        coursesCollectionView?.anchor(
            top: contentView.topAnchor,
            right: contentView.rightAnchor,
            bottom: contentView.bottomAnchor,
            left: contentView.leftAnchor)
        
    }
    
    // Credit goes to Ash Furrow
    func setCollectionViewDataSourceDelegate
        <D: UICollectionViewDataSource & UICollectionViewDelegate>
        (dataSourceDelegate: D, forRow row: Int) {
        
        coursesCollectionView?.delegate = dataSourceDelegate
        coursesCollectionView?.dataSource = dataSourceDelegate
        coursesCollectionView?.tag = row
        coursesCollectionView?.reloadData()
    }
}
