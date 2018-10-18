//
//  ProjectsCollectionCell.swift
//  companion
//
//  Created by Uchenna  Aguocha on 10/17/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import UIKit

class ProjectsCollectionCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static var projectsCollectionCellId = "projectsCollectionCellId"
    
    // MARK: - UI Elements
    
    let projectImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 2
        return imageView
    }()
    
    let projectNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Companion App"
        label.textColor = MakeSchoolDesignColor.darkGrey
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 17)
        return label
    }()
    
    let technologiesLabel: UILabel = {
        let label = UILabel()
        label.text = "Companion App"
        label.textColor = MakeSchoolDesignColor.darkGrey
        label.font = UIFont(name: "AvenirNext-Medium", size: 12)
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupAutoLayout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupAutoLayout() {
        
        contentView.addSubviews(views: containerView)
        
        containerView.anchor(
            top: contentView.topAnchor,
            right: contentView.rightAnchor,
            bottom: contentView.bottomAnchor,
            left: contentView.leftAnchor)
        
        containerView.addSubviews(views: projectImageView, projectNameLabel, technologiesLabel)
        
        projectImageView.anchor(
            top: containerView.topAnchor,
            right: containerView.rightAnchor,
            bottom: nil,
            left: containerView.leftAnchor,
            topPadding: 0,
            rightPadding: 0,
            bottomPadding: 0,
            leftPadding: 0,
            height: 26,
            width: 0)
        
        projectNameLabel.anchor(
            top: projectImageView.bottomAnchor,
            right: containerView.rightAnchor,
            bottom: nil,
            left: containerView.leftAnchor,
            topPadding: 12,
            rightPadding: 12,
            bottomPadding: 0,
            leftPadding: 12,
            height: 26,
            width: 0)
        
        technologiesLabel.anchor(
            top: projectNameLabel.bottomAnchor,
            right: containerView.rightAnchor,
            bottom: nil,
            left: containerView.leftAnchor,
            topPadding: 5,
            rightPadding: 12,
            bottomPadding: 0,
            leftPadding: 12,
            height: 20,
            width: 0)
        
    }
    
    
    
}
