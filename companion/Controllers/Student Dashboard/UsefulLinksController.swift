//
//  UsefulLinksController.swift
//  companion
//
//  Created by Uchenna  Aguocha on 11/17/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit

class UsefulLinksController: UITableViewController {
    
    private let staticLinks = [
        StaticLink(name: "Make School Wiki", url: "https://www.notion.so/productcollege/Product-College-Wiki-0cc6b85fd77343c0b87e28996f96b280"),
        StaticLink(name: "Student Handbook", url: "https://docs.google.com/document/d/1YC_2t9y1raTdx4rtLWWD9uZthYqiZjDXAnGMBRvjge4/preview"),
        StaticLink(name: "Degree Path", url: "https://docs.google.com/document/d/1C4Nm-aWa-l_omuyJRkOoNCBpxcK4LvyYlhcdzvNjwGs/preview"),
        StaticLink(name: "Manage ISAs on Vemo", url: "https://vemo.com/"),
        StaticLink(name: "Academic Calendar", url: "https://docs.google.com/document/d/1ng455nKrGYjxjf_MKh8lx7LDz-OsgexFEBFChPSw9Qw/preview")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = MakeSchoolDesignColor.faintBlue
        self.navigationController?.navigationItem.title = "Useful Links"
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StaticLinksCell.self, forCellReuseIdentifier: StaticLinksCell.cellId)
    }

}

// MARK: - Delegate and DataSource Methods
extension UsefulLinksController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StaticLinksCell.cellId, for: indexPath) as? StaticLinksCell else {
            fatalError("Failed to instantiate a StaticLinksCell")
        }
        let staticLink = staticLinks[indexPath.row]
    
        cell.linkLabel.text = staticLink.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return staticLinks.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let staticLink = staticLinks[indexPath.row]
        guard let url = URL(string: staticLink.url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    
}
