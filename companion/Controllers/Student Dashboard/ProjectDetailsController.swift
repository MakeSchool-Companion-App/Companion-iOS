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
    
    var project: Project? {
        didSet {
            
            DispatchQueue.main.async {
                guard let imageUrl = URL(string: self.project?.img_url ?? ""),
                let imageData = try? Data(contentsOf: imageUrl) else { return }
                self.projectImageView.image = UIImage(data: imageData)
            }
            
            projectNameLabel.text = project?.name
            projectDescriptionTextView.text = project?.description
            projectTechnologiesLabel.text = "Technologies: \(project?.technologies ?? "")"
        }
    }
    
    // MARK: UI Elements
    
    let projectImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let projectNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Bold", size: 23)
        return label
    }()
    
    let projectDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.textColor = .black
        textView.font = UIFont(name: "AvenirNext-Regular", size: 17)
        textView.textAlignment = .left
        textView.isEditable = false 
        textView.backgroundColor = .clear
        return textView
    }()
    
    let projectTechnologiesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 17)
        return label
    }()
    
    
    // MARK: View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MakeSchoolDesignColor.faintBlue
        self.navigationController?.navigationBar.tintColor = MakeSchoolDesignColor.faintBlue
        setupAutoLayout()
    }

    // MARK: Methods
    
    fileprivate func setupAutoLayout() {
        
        projectNameLabel.anchor(top: nil, right: nil, bottom: nil, left: nil, topPadding: 0, rightPadding: 0, bottomPadding: 0, leftPadding: 0, height: 30, width: 0)
        
        projectDescriptionTextView.anchor(top: nil, right: nil, bottom: nil, left: nil, topPadding: 0, rightPadding: 0, bottomPadding: 0, leftPadding: 0, height: 140, width: 0)
        
        projectTechnologiesLabel.anchor(top: nil, right: nil, bottom: nil, left: nil, topPadding: 0, rightPadding: 0, bottomPadding: 0, leftPadding: 0, height: 25, width: 0)
        

        let stackView = UIStackView(arrangedSubviews: [projectNameLabel, projectDescriptionTextView, projectTechnologiesLabel])
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 10
        
        view.addSubviews(views: projectImageView, stackView)
        
        
        projectImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, right: view.rightAnchor, bottom: nil, left: view.leftAnchor, topPadding: 0, rightPadding: 0, bottomPadding: 0, leftPadding: 0, height: 230, width: 0)
        
        
        stackView.anchor(top: projectImageView.bottomAnchor, right: view.rightAnchor, bottom: nil, left: view.leftAnchor, topPadding: 10, rightPadding: 10, bottomPadding: 0, leftPadding: 10, height: 240, width: 0)
        
        
//        projectImageView.insertSubview(backButton, aboveSubview: projectImageView)
        
    }
    
}


