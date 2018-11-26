//
//  StudentDashboardController .swift
//  companion
//
//  Created by Uchenna  Aguocha on 10/16/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//


import UIKit

class StudentDashboardController: UITableViewController {
    
     // MARK: - Properties
    
    var profile: Profile?
    
    var projects = [Project]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }
    }
    
    var project: Project?
    
    var courses: [Course] = [
        Course(name: "DS 1.1", description: "Data Analysis & Visualization", color: UIColor.purple),
        Course(name: "MOB 1.1", description: "Concurrency & Parallelism ", color: UIColor.red),
        Course(name: "CS 1.1", description: "Intro to Python & OOP", color: UIColor.blue)
    ]
    
    // MARK: - View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        fetchUserProfileAndProjects()
    }
    
    
    // MARK: - Methods
    
    fileprivate func setupTableView() {
        
        tableView?.backgroundColor = MakeSchoolDesignColor.faintBlue
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView.separatorStyle = .none 
        tableView.register(UserProfileSectionCell.self, forCellReuseIdentifier: UserProfileSectionCell.cellId)
        tableView.register(ProjectsSectionCell.self, forCellReuseIdentifier: ProjectsSectionCell.cellId)
        tableView.register(CoursesSectionCell.self, forCellReuseIdentifier: CoursesSectionCell.cellId)
        tableView.register(UsefulLinkSectionCell.self, forCellReuseIdentifier: UsefulLinkSectionCell.cellId)

    }
    
    fileprivate func fetchUserProfileAndProjects() {
        
        ProfileService.show(user_id: Int(User.current?.user_id ?? "0")) { (profile) in
            
            DispatchQueue.global().async {
                self.profile = profile
            }
            
            DispatchQueue.global().async {
                ProjectServices.show(slug: profile.slug, completion: { (projects) in
                    if let projects = projects as? [Project] {
                        self.projects = projects
                    }
                })
            }
        }
        
    }
    
}

// MARK: - Delegate & DataSource Methods

extension StudentDashboardController: UICollectionViewDelegateFlowLayout {
   
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            // User Profile
            guard let userProfileCell = tableView.dequeueReusableCell(withIdentifier: UserProfileSectionCell.cellId, for: indexPath) as? UserProfileSectionCell else { fatalError("StudentDashboardController: failed to create a UserProileSectionCell") }
            userProfileCell.profile = profile
            
            return userProfileCell
            
        case 1:
            // Projects Section
            guard let projectsSectionCell = tableView.dequeueReusableCell(withIdentifier: ProjectsSectionCell.cellId, for: indexPath) as? ProjectsSectionCell else { fatalError("StudentDashboardController: failed to create a ProjectsSectionCell") }
    
            projectsSectionCell.projects = projects
            projectsSectionCell.delegate = self
            
            return projectsSectionCell
            
        case 2:
            // Courses Section
            guard let coursesSectionCell = tableView.dequeueReusableCell(withIdentifier: CoursesSectionCell.cellId, for: indexPath) as? CoursesSectionCell else { fatalError("StudentDashboardController: failed to create a CoursesSectionCell") }
            print("Courses: \(courses)")
            coursesSectionCell.courses = courses
            return coursesSectionCell
            
        case 3:
            // Useful Links Section
            guard let usefulLinksSectionCell = tableView.dequeueReusableCell(withIdentifier: UsefulLinkSectionCell.cellId, for: indexPath) as? UsefulLinkSectionCell else { fatalError("StudentDashboardController: failed to create a UsefulLinkSectionCell") }
            usefulLinksSectionCell.userLinkButton.addTarget(self, action: #selector(showStaticLinks), for: .touchUpInside)
            return usefulLinksSectionCell
            
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 160
        case 1: return 250
        case 2: return 157
        case 3: return 100
        default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 0: return nil 
        case 1:
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
            
        case 2:
            
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
        default: return UILabel()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0: return 0
        case 1: return 30
        case 2: return 30
        case 3: return 0
        default: return 0
        }
    }
    
}

extension StudentDashboardController {
    @objc func showStaticLinks() {
        self.navigationController?.pushViewController(UsefulLinksController(), animated: true)
        
    }
}

extension StudentDashboardController: ProjectsSectionCellDelegate {
    
    func displayProject(project: Project) {

        let projectDetailsController = ProjectDetailsController()
        projectDetailsController.project = project
        print(project)
        self.present(projectDetailsController, animated: true, completion: nil)
        
    }
    
    
}


