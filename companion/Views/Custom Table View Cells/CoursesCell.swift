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
    
    var courses = [Course]() {
        didSet {
            DispatchQueue.main.async {
                self.coursesCollectionView?.reloadData()
            }
        }
    }
    
    // MARK: - UI Elements
    
    var coursesCollectionView: UICollectionView?
    
    
    // MARK: - Initializers
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        backgroundColor = MakeSchoolDesignColor.lightBlue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupCollectionView()
        setupAutoLayout()
    }
    
    // MARK: - Methods
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 14
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        
        coursesCollectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        coursesCollectionView?.delegate = self
        coursesCollectionView?.dataSource = self
        coursesCollectionView?.backgroundColor = MakeSchoolDesignColor.faintBlue
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
//    func setCollectionViewDataSourceDelegate
//        <D: UICollectionViewDataSource & UICollectionViewDelegate>
//        (dataSourceDelegate: D, forRow row: Int, indexPath: IndexPath) {
//
//        coursesCollectionView?.delegate = dataSourceDelegate
//        coursesCollectionView?.dataSource = dataSourceDelegate
//        coursesCollectionView?.tag = row
//        UserDefaults.standard.set(indexPath.section, forKey: "cellSection")
//
//        coursesCollectionView?.reloadData()
//
//    }
}

// MARK: - CollectionView DelegateFlowLayout & DataSource Methods

extension CoursesCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoursesCollectionCell.coursesCollectionCellId, for: indexPath) as? CoursesCollectionCell else { fatalError("CoursesCell: failed to create a collectionViewCell") }
        let course = courses[indexPath.item]
        
        cell.courseTitleLabel.text = course.name
        cell.courseSubtitleLabel.text = course.description
        cell.containerView.backgroundColor = course.color
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 143)
        
    }
    
}
