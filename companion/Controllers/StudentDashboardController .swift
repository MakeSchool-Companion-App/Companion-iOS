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
    
    // Dummy Data
    var projects: [Project] = [
        Project(name: "Companion App", technologies: "Swift & UIKit", image: UIImage(named: "makeschool")!),
        Project(name: "Instagram", technologies: "Swift, GraphQL, & Rails", image: UIImage(named: "instagram")!),
        Project(name: "Twitter", technologies: "Swift, GraphQL, & Rails", image: UIImage(named: "twitter")!),
        Project(name: "Snapchat", technologies: "Swift, GraphQL, & Rails", image: UIImage(named: "snapchat")!)
    ]
    // Dummy Data
    var courses: [Course] = [
        Course(name: "DS 1.1", description: "Data Analysis & Visualization", color: UIColor.purple),
        Course(name: "MOB 1.1", description: "Concurrency & Parallelism ", color: UIColor.red),
        Course(name: "CS 1.1", description: "Intro to Python & OOP", color: MakeSchoolDesignColor.mediumBlue)
    ]
    
    
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
        return 1
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case 0:
            // Projects Cell
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProjectsCell.projectsCellId, for: indexPath) as? ProjectsCell else { fatalError("Failed to create a ProjectsCell") }
            cell.projects = projects
            
            return cell
            
        case 1:
            // Courses Cell
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CoursesCell.coursesCellId, for: indexPath) as? CoursesCell else {
                fatalError("Failed to create a CoursesCell")
            }
            
            cell.courses = courses
            
            return cell
            
        default: return UITableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 249
        case 1: return 157
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Profile"
        case 1: return "My Courses"
        default: return ""
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        
        switch section {
        case 0:
            let headerContainerView = UIView()
            headerContainerView.frame = CGRect(x: 0, y: 0, width: 101, height: 31)
            headerContainerView.backgroundColor = MakeSchoolDesignColor.faintBlue
            
            let projectsHeaderLabel = UILabel()
            projectsHeaderLabel.frame = CGRect(x: 10, y: 0, width: 101, height: 31)
            projectsHeaderLabel.text = "Projects"
            projectsHeaderLabel.font = UIFont(name: "AvenirNext-Bold", size: 23)
            projectsHeaderLabel.textColor = MakeSchoolDesignColor.black
            projectsHeaderLabel.textAlignment = .left
            
            headerContainerView.addSubview(projectsHeaderLabel)
            
            return headerContainerView
            
        case 1:
            
            let headerContainerView = UIView()
            headerContainerView.frame = CGRect(x: 0, y: 0, width: 144, height: 31)
            headerContainerView.backgroundColor = MakeSchoolDesignColor.faintBlue
            
            let coursesHeaderLabel = UILabel()
            coursesHeaderLabel.frame = CGRect(x: 10, y: 0, width: 144, height: 31)
            coursesHeaderLabel.text = "My Courses"
            coursesHeaderLabel.font = UIFont(name: "AvenirNext-Bold", size: 23)
            coursesHeaderLabel.textColor = MakeSchoolDesignColor.black
            coursesHeaderLabel.textAlignment = .left
            
            headerContainerView.addSubview(coursesHeaderLabel
            )
            
            return headerContainerView
        default:
            return UILabel()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
}

//extension StudentDashboardController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        UserDefaults.standard.set(indexPath.section, forKey: "cellSection")
//        switch indexPath.section {
//
//        case 0:
//            guard let projectsCell = tableView.dequeueReusableCell(withIdentifier: ProjectsCell.projectsCellId, for: indexPath) as? ProjectsCell else {fatalError("Student Dashboard: Failed to configure ProjectsCell")}
//
//            projectsCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.section)
//
//            print("Projects IndexPathRow: \(indexPath.section)")
//            return projectsCell
//
//        case 1:
//            guard let coursesCell = tableView.dequeueReusableCell(withIdentifier: CoursesCell.coursesCellId , for: indexPath) as? CoursesCell else {fatalError("Student Dashboard: Failed to configure CoursesCell")}
//            coursesCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.section, indexPath: indexPath)
//            print("Courses IndexPathRow: \(indexPath.section)")
//            return coursesCell
//
//        default:
//            return UITableViewCell()
//
//        }
//    }
//
////    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////
////        UserDefaults.standard.set(indexPath.section, forKey: "cellSection")
////
////    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        switch section {
//        case 0:
//            return "Projects"
//        case 1:
//            return "My Courses"
//        default:
//            return ""
//        }
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        switch indexPath.row {
//        case 0: return 249
//        case 1: return 157
//        default: return 0
//        }
//    }
//
//}

// MARK: - CollectionView Delegate & DataSource Methods
//
//extension StudentDashboardController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        print("This is the collection view tag: \(collectionView.tag)")
//        switch collectionView.tag {
//        case 0: return 3
//        case 1: return 5
//        default: return 1
//        }
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//       let cellSection = UserDefaults.standard.value(forKey: "cellSection") as! Int
//        print(indexPath.section)
//
//        switch cellSection{
//        case 0:
//            guard let projectsCollectionView = collectionView.dequeueReusableCell(withReuseIdentifier: ProjectsCollectionCell.projectsCollectionCellId, for: indexPath) as? ProjectsCollectionCell else {
//                fatalError("Student Dashboard: failed to configure ProjectsCollectionCell.")
//            }
//
//            print("ProjectCollectionView Index: \(indexPath)")
//
//            return projectsCollectionView
//
//        case 1:
//            guard let coursesCollectionView = collectionView.dequeueReusableCell(withReuseIdentifier: CoursesCollectionCell.coursesCollectionCellId, for: indexPath) as? CoursesCollectionCell else {
//                fatalError("Student Dashboard: failed to configure CoursesCollectionCell.")
//            }
//
//            print("CoursesCollectionView Index: \(indexPath)")
//            return coursesCollectionView
//
//        default:
//            // Return an empty collection view cell
//            return UICollectionViewCell()
//        }
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        switch collectionView.tag {
//        case 0: return CGSize(width: 180, height: 212)
//        case 1: return CGSize(width: 180, height: 143)
//        default: return CGSize(width: 0, height: 0)
//        }
//
//
//    }
//
//
//}





















