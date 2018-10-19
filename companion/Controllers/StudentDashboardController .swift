//
//  StudentDashboardController .swift
//  companion
//
//  Created by Uchenna  Aguocha on 10/16/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//


import UIKit

class StudentDashboardController: UIViewController {
    
    // MARK: TODO: Fetch students courses and projects from MAKE SCHOOL API
    
    
    
    // MARK: - Properties
    
    
    
    // MARK: - UI Elements
    
    lazy var dashboardTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    let profileCardView = ProfileCardView()
    
    // MARK: - View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAutoLayout()
    }
    
    // MARK: - Methods
    
    private func setupAutoLayout() {
        
        // MARK: TODO: - Add constraints to each subview
        
        view.addSubviews(views: profileCardView, dashboardTableView)
        
        profileCardView.anchor(
            top: view.topAnchor,
            right: view.rightAnchor,
            bottom: nil,
            left: view.leftAnchor,
            topPadding: 10,
            rightPadding: 10,
            bottomPadding: 0,
            leftPadding: 10,
            height: 156,
            width: 0)
        
        dashboardTableView.anchor(
            top: profileCardView.bottomAnchor,
            right: view.rightAnchor,
            bottom: view.bottomAnchor,
            left: view.leftAnchor,
            topPadding: 0,
            rightPadding: 0,
            bottomPadding: 0,
            leftPadding: 0,
            height: 478,
            width: 0)
        
        
    }
    
    
}

// MARK: TableView Delegate & DataSource Methods

extension StudentDashboardController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
            
        // Project Section
        case 0:
            return 4
        // Course Section
        case 1:
            return 4
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case 0:
            guard let projectsCell = tableView.dequeueReusableCell(withIdentifier: ProjectsCell.projectsCellId, for: indexPath) as? ProjectsCell else {fatalError("Student Dashboard: Failed to configure ProjectsCell")}
            
            projectsCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
            return projectsCell
            
        case 1:
            guard let coursesCell = tableView.dequeueReusableCell(withIdentifier: CoursesCollectionCell.coursesCollectionCellId , for: indexPath) as? CoursesCell else {fatalError("Student Dashboard: Failed to configure CoursesCell")}
            coursesCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
            return coursesCell
        
        default:
            return UITableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Projects"
        case 1:
            return "My Courses"
        default:
            return ""
        }
    }
    
}

// MARK: - CollectionView Delegate & DataSource Methods

extension StudentDashboardController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        default:
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            guard let projectsCollectionView = collectionView.dequeueReusableCell(withReuseIdentifier: ProjectsCollectionCell.projectsCollectionCellId, for: indexPath) as? ProjectsCollectionCell else {
                fatalError("Student Dashboard: failed to configure ProjectsCollectionCell.")
            }
            return projectsCollectionView
            
        case 1:
            guard let coursesCollectionView = collectionView.dequeueReusableCell(withReuseIdentifier: CoursesCollectionCell.coursesCollectionCellId, for: indexPath) as? CoursesCollectionCell else {
                fatalError("Student Dashboard: failed to configure CoursesCollectionCell.")
            }
            return coursesCollectionView
            
        default:
            // Return an empty collection view cell
            return UICollectionViewCell()
        }
        
    }
    
    
    
    
}





















