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
    
    var projects = [Project]() {
        didSet {
//            DispatchQueue.main.async {
                self.projectsCollectionView?.reloadData()
            }
//        }
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
    
    private func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 14
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        projectsCollectionView = UICollectionView(frame: self.frame, collectionViewLayout: flowLayout)
        
        projectsCollectionView?.delegate = self
        projectsCollectionView?.dataSource = self
        projectsCollectionView?.backgroundColor = MakeSchoolDesignColor.faintBlue
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
//    func setCollectionViewDataSourceDelegate
//        <D: UICollectionViewDataSource & UICollectionViewDelegate>
//        (dataSourceDelegate: D, forRow row: Int) {
//        projectsCollectionView?.delegate = dataSourceDelegate
//        projectsCollectionView?.dataSource = dataSourceDelegate
//        projectsCollectionView?.tag = row
//        projectsCollectionView?.reloadData()
//    }
}

extension ProjectsCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return projects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProjectsCollectionCell.projectsCollectionCellId, for: indexPath) as? ProjectsCollectionCell else { fatalError("ProjectsCell: failed to create a collectionViewCell") }
        let project = projects[indexPath.row]
        
        print("Project Image: \(project.img_url)")
        
        
        cell.projectNameLabel.text = project.name
        cell.technologiesLabel.text = project.technologies
        DispatchQueue.main.async {
            if let url = URL(string: project.img_url),
                let data = try? Data(contentsOf: url) {
                let projectImage = UIImage(data: data)
                cell.projectImageView.image = projectImage
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 212)
    }
    

    
}



//extension UICollectionView{
//    func colletionType (section: Int) -> String{
//        switch section{
//        case 0: return "course"
//        case 1: return "project"
//        default: return ""
//        }
//    }
//}
//class CustomCollection: UICollectionView{
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
