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
    
    var dashboardTableView: UITableView?
    
    let profileCardView = ProfileCardView()
    
    // MARK: - View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MakeSchoolDesignColor.faintBlue
        
        setupTableView()
        setupAutoLayout()
    }
    
    // MARK: - Methods
    
    private func setupTableView() {
        dashboardTableView = UITableView()
        dashboardTableView?.separatorStyle = .none
        dashboardTableView?.delegate = self
        dashboardTableView?.dataSource = self
        dashboardTableView?.register(ProjectsCell.self, forCellReuseIdentifier: ProjectsCell.projectsCellId)
        dashboardTableView?.register(CoursesCell.self, forCellReuseIdentifier: CoursesCell.coursesCellId)
    }
    
    private func setupAutoLayout() {
        
        // MARK: TODO: - Add constraints to each subview
        
        view.addSubviews(views: profileCardView, dashboardTableView ?? UITableView())
        
        profileCardView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            bottom: nil,
            left: view.safeAreaLayoutGuide.leftAnchor,
            topPadding: 10,
            rightPadding: 10,
            bottomPadding: 0,
            leftPadding: 10,
            height: 156,
            width: 0)
        
        dashboardTableView?.anchor(
            top: profileCardView.bottomAnchor,
            right: view.rightAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            left: view.leftAnchor,
            topPadding: 0,
            rightPadding: 0,
            bottomPadding: 0,
            leftPadding: 0,
            height: 0,
            width: 0)
        
        
    }
    
    
}

// MARK: TableView Delegate & DataSource Methods

extension StudentDashboardController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
            
        // Project Section
        case 0:
            return 1
        // Course Section
        case 1:
            return 1
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case 0:
            guard let projectsCell = tableView.dequeueReusableCell(withIdentifier: ProjectsCell.projectsCellId, for: indexPath) as? ProjectsCell else {fatalError("Student Dashboard: Failed to configure ProjectsCell")}
        
            projectsCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
            
            print("Projects IndexPathRow: \(indexPath.section)")
            return projectsCell
            
        case 1:
            guard let coursesCell = tableView.dequeueReusableCell(withIdentifier: CoursesCell.coursesCellId , for: indexPath) as? CoursesCell else {fatalError("Student Dashboard: Failed to configure CoursesCell")}
            coursesCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.section)
            print("Courses IndexPathRow: \(indexPath.section)")
            return coursesCell
        
        default:
            return UITableViewCell()
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0: return 249
        case 1: return 157
        default: return 0
        }
    }
    
}

// MARK: - CollectionView Delegate & DataSource Methods

extension StudentDashboardController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("This is the collection view tag: \(collectionView.tag)")
        switch collectionView.tag {
        case 0: return 3
        case 1: return 5
        default: return 1
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView.tag {
        case 0: return CGSize(width: 180, height: 212)
        case 1: return CGSize(width: 180, height: 143)
        default: return CGSize(width: 0, height: 0)
        }
        
        
    }
    
    
}





















