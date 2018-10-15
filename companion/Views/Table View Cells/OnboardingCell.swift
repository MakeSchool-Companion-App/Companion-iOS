//
//  OnboardingCell.swift
//  companion
//
//  Created by Uchenna  Aguocha on 9/28/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let onboardingCellID = "onboardingCellID"
    
    // MARK: - UI Elements
    
    private let topImageContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .center
        textView.textColor = .black
        textView.font = UIFont(name: "AvenirNext-Medium", size: 22)
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    private let bottomOnboardingView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
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
    
    fileprivate func setupAutoLayout() {
        
        // Add contentView subviews - topImageViewContainerView & bottomOnboardingView
        contentView.addSubviews(views: topImageContainerView, bottomOnboardingView)
        
        // Add constraints
        topImageContainerView.anchor(
            top: contentView.safeAreaLayoutGuide.topAnchor,
            right: contentView.safeAreaLayoutGuide.rightAnchor,
            bottom: nil,
            left: contentView.safeAreaLayoutGuide.leftAnchor,
            topPadding: 0,
            rightPadding: 0,
            bottomPadding: 0,
            leftPadding: 0,
            height: 0,
            width: 0)
        
        topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        
        bottomOnboardingView.anchor(
            top: topImageContainerView.bottomAnchor,
            right: contentView.safeAreaLayoutGuide.rightAnchor,
            bottom: contentView.safeAreaLayoutGuide.bottomAnchor,
            left: contentView.safeAreaLayoutGuide.leftAnchor,
            topPadding: 0,
            rightPadding: 0,
            bottomPadding: 0,
            leftPadding: 0,
            height: 0,
            width: 0)
        
        topImageContainerView.addSubview(thumbnailImageView)
        bottomOnboardingView.addSubview(descriptionTextView)
        
        thumbnailImageView.centerAnchor(
            centerX: topImageContainerView.centerXAnchor,
            centerY: topImageContainerView.centerYAnchor)
        thumbnailImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        
        descriptionTextView.anchor(
            top: bottomOnboardingView.topAnchor,
            right: bottomOnboardingView.rightAnchor,
            bottom: bottomOnboardingView.bottomAnchor,
            left: bottomOnboardingView.leftAnchor,
            topPadding: 50,
            rightPadding: 32,
            bottomPadding: 0,
            leftPadding: 32,
            height: 0,
            width: 0)

        
    }
    
}
