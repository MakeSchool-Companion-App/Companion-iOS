//
//  ProjectDetailsController.swift
//  companion
//
//  Created by Uchenna  Aguocha on 11/15/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit

class ProjectDetailsController: UIViewController {
    
    // MARK: Properties
    
    var projectViewModel: ProjectViewModel? {
        didSet {
            guard let projectViewModel = projectViewModel else { return }
            DispatchQueue.main.async {
                guard let imageUrl = URL(string: projectViewModel.imageUrl),
                let imageData = try? Data(contentsOf: imageUrl) else { return }
                self.projectImageView.image = UIImage(data: imageData)
            }

            projectNameLabel.text = projectViewModel.name
            projectDescriptionTextView.text = projectViewModel.description
            projectTechnologiesLabel.text = projectViewModel.technologies
        }
    }
    
    // MARK: UI Elements
    
    let projectImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let projectNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext Demi-Bold", size: 17)
        return label
    }()
    
    let projectDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.textColor = .black
        textView.font = UIFont(name: "AvenirNext Demi-Bold", size: 17)
        textView.textAlignment = .left
        return textView
    }()
    
    let projectTechnologiesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext Demi-Bold", size: 17)
        return label
    }()
    
    // MARK: View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MakeSchoolDesignColor.faintBlue
        setupAutoLayout()
    }

    // MARK: Methods
    
    fileprivate func setupAutoLayout() {
        
        let stackView = UIStackView(arrangedSubviews: [projectNameLabel, projectDescriptionTextView, projectTechnologiesLabel])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 10
        
        view.addSubviews(views: projectImageView, stackView)
        
        projectImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, right: view.rightAnchor, bottom: nil, left: view.leftAnchor, topPadding: 0, rightPadding: 0, bottomPadding: 0, leftPadding: 0, height: 230, width: 0)
        
        stackView.anchor(top: projectImageView.bottomAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, topPadding: 10, rightPadding: 10, bottomPadding: 10, leftPadding: 20, height: 0, width: 0)
        
    }
    
}


