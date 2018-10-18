//
//  CoursesCollectionCell.swift
//  companion
//
//  Created by Uchenna  Aguocha on 10/17/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit

class CoursesCollectionCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static var coursesCollectionCellId = "coursesCollectionCellId"
    
    // MARK: - UI Elements
    
    let courseTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "DS 1.1"
        label.textColor = MakeSchoolDesignColor.faintBlue
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 19)
        label.textAlignment = .center
        return label
    }()
    
    let courseSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Data Analysis & Visualization"
        label.textColor = MakeSchoolDesignColor.faintBlue
        label.font = UIFont(name: "AvenirNext-Medium", size: 17)
        label.textAlignment = .center
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.backgroundColor = MakeSchoolDesignColor.darkBlue
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
        
        containerView.addSubviews(views: courseTitleLabel, courseSubtitleLabel)
        
        courseTitleLabel.anchor(
            centerX: containerView.centerXAnchor,
            centerY: nil,
            top: containerView.topAnchor,
            right: containerView.rightAnchor,
            bottom: nil,
            left: containerView.leftAnchor,
            topPadding: 39,
            rightPadding: 43,
            bottomPadding: 0,
            leftPadding: 43,
            height: 23,
            width: 0)
        
        courseSubtitleLabel.anchor(
            centerX: containerView.centerXAnchor,
            centerY: nil,
            top: courseTitleLabel.bottomAnchor,
            right: containerView.rightAnchor,
            bottom: nil,
            left: containerView.leftAnchor,
            topPadding: 0,
            rightPadding: 10,
            bottomPadding: 0,
            leftPadding: 10,
            height: 49,
            width: 0)
        
    }
    
    
    
    
}
