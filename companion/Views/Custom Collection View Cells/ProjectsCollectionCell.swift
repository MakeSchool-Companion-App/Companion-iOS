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
    
    lazy var projectImageView: UIImageView = {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 6, height: 6))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
//        imageView.layer.cornerRadius = 6
        imageView.layer.mask = maskLayer
        
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
        view.layer.cornerRadius = 6
        view.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowOpacity = 0.25
        view.layer.shadowRadius = 5
        view.backgroundColor = MakeSchoolDesignColor.faintBlue
        return view
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Life Cycle Methods
    
    override func layoutSubviews() {
        setupAutoLayout()
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
            height: 120,
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
