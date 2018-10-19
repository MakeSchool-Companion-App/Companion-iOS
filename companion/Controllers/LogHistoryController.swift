//
//  LogHistoryController.swift
//  companion
//
//  Created by Uchenna  Aguocha on 9/14/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit

class LogHistoryController: UIViewController {
    
    // MARK: - Properties
    

//    lazy var attendaceViewModel = AttendanceViewModel()
    
    // MARK: - UI Elements
    
    lazy var logHistoryTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .blue
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(LogHistoryCell.self, forCellReuseIdentifier: LogHistoryCell.logHistoryCellId)
        return tableView
    }()
    
    lazy var navigationBar: UINavigationBar = {
        let screenSize = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 44))
        navBar.backgroundColor = .white

        let navItem = UINavigationItem(title: "Log History")
        navBar.setItems([navItem], animated: false)
        return navBar
    }()
    
    // MARK: - View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupAutoLayout()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        UIApplication.shared.statusBarStyle = .lightContent
//    }
    
//    override var preferredStatusBarStyle : UIStatusBarStyle {
//        return .lightContent
//    }
    
    // MARK: - Methods
    
    
    
    private func setupAutoLayout() {
        
        // SubView
        
        view.addSubviews(views: navigationBar, logHistoryTableView)
        
        // Constraints
        
        navigationBar.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            bottom: nil,
            left: view.safeAreaLayoutGuide.leftAnchor,
            topPadding: 0,
            rightPadding: 0,
            bottomPadding: 0,
            leftPadding: 0,
            height: 44,
            width: 0)
        
        logHistoryTableView.anchor(
            top: navigationBar.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            bottom: view.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            topPadding: 0,
            rightPadding: 0,
            bottomPadding: 0,
            leftPadding: 0,
            height: 0,
            width: 0)
        
    }
    
}

extension LogHistoryController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - TableView DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LogHistoryCell.logHistoryCellId, for: indexPath) as? LogHistoryCell else { fatalError("TableViewCell Failed")}
        
//        cell.enterDateLabel.text = attendaceViewModel.event
//        cell.exitDateLabel.text = attendaceViewModel.event
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    // MARK: - TableView Delegate Methods
    
    
    
}
