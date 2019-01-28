//
//  ProjectsSectionCell.swift
//  companion
//
//  Created by Uchenna  Aguocha on 10/17/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit


protocol ProjectsSectionCellDelegate: class {
    func displayProject(project: Project)
}

class ProjectsSectionCell: UITableViewCell {
    
    // MARK: - Properties
    
    static var cellId = "projectsCellId"
    weak var delegate: ProjectsSectionCellDelegate?
    
    var projects = [Project]() {
        didSet {
            DispatchQueue.main.async {
                self.projectsCollectionView?.reloadData()
            }
        }
    }

    // MARK: - UI Elements
    
    var projectsCollectionView: UICollectionView?
    
    
    // MARK: - Initializers
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupCollectionView()
        setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    fileprivate func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 14
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        projectsCollectionView = UICollectionView(frame: self.frame, collectionViewLayout: flowLayout)
        projectsCollectionView?.delegate = self
        projectsCollectionView?.dataSource = self
        projectsCollectionView?.backgroundColor = MakeSchoolDesignColor.faintBlue
        projectsCollectionView?.register(ProjectsCollectionCell.self, forCellWithReuseIdentifier: ProjectsCollectionCell.cellId)
    }
    
    fileprivate func setupAutoLayout() {
        
        contentView.addSubview(projectsCollectionView ?? UICollectionView())
        
        projectsCollectionView?.anchor(
            top: contentView.topAnchor,
            right: contentView.rightAnchor,
            bottom: contentView.bottomAnchor,
            left: contentView.leftAnchor)
        
    }
    

}

extension ProjectsSectionCell:  UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return projects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProjectsCollectionCell.cellId, for: indexPath) as? ProjectsCollectionCell else { fatalError("ProjectsSectionCell: failed to create a collectionViewCell") }
        let project = projects[indexPath.row]
        print("Project Image URL: \(project.img_url)")
        DispatchQueue.main.async {
            cell.projectNameLabel.text = project.name
            cell.technologiesLabel.text = project.technologies

            DispatchQueue.global().async {
                if let url = URL(string: project.img_url),
                    let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        cell.projectImageView.image = UIImage(data: data)
                    }
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 212)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let project = projects[indexPath.item]
        delegate?.displayProject(project: project)
    }
    
    
}




