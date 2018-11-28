//
//  ProjectViewModelTests.swift
//  companionTests
//
//  Created by Uchenna  Aguocha on 11/27/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import XCTest
@testable import companion

class ProjectViewModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreatingProjectViewModel() {
        let project = Project(name: "CompanionApp", technologies: "Swift, React Native, Rails", img_url: "", writeup_url: "", github_url: "https://github.com/MakeSchool-Companion-App", uri: "", id: 0000, description: "Hello Snappers")
        let projectViewModel = ProjectViewModel(project: project)
        
        XCTAssertEqual(project.name, projectViewModel.name, "The project's name should match projectViewModel's name")
        XCTAssertEqual(project.technologies, projectViewModel.technologies, "The project's technologies should match projectViewModel's technologies")
        XCTAssertEqual(project.id, projectViewModel.id, "The project's id should match projectViewModel's id")
        XCTAssertEqual(project.description, projectViewModel.description, "The project's description should match projectViewModel's description")
    }

}
