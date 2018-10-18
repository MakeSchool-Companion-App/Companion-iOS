//
//  ProfileCardView.swift
//  companion
//
//  Created by Uchenna  Aguocha on 10/17/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit

class ProfileCardView: UIView {
    
    // MARK: - UI Elements
    
    let profilePictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.borderWidth = 2
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "John Doe"
        label.textAlignment = .center
        label.textColor = MakeSchoolDesignColor.black
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 23)
        return label
    }()
    
    let concentrationLabel: UILabel = {
        let label = UILabel()
        label.text = "Mobile Developer"
        label.textAlignment = .center
        label.textColor = MakeSchoolDesignColor.darkGrey
        label.font = UIFont(name: "AvenirNext", size: 16)
        return label
    }()
    
    let biographyTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.text = "I'm the best developer in the world, and I love to bike around SF and sleep."
        textView.textColor = MakeSchoolDesignColor.darkGrey
        textView.textAlignment = .left
        textView.font = UIFont(name: "AvenirNext-Medium", size: 12)
        return textView
    }()
    
    let editButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(MakeSchoolDesignColor.faintBlue, for: .normal)
        button.backgroundColor = MakeSchoolDesignColor.darkBlue
        button.layer.cornerRadius = 6
        return button
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    private func setupAutoLayout() {
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, concentrationLabel])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 10
        
        addSubviews(views: profilePictureImageView, editButton, stackView, biographyTextView)
        
        profilePictureImageView.anchor(
            top: topAnchor,
            right: nil,
            bottom: nil,
            left: leftAnchor,
            topPadding: 10,
            rightPadding: 0,
            bottomPadding: 0,
            leftPadding: 10,
            height: 95,
            width: 95)
        
        editButton.anchor(
            centerX: profilePictureImageView.centerXAnchor,
            centerY: nil,
            top: profilePictureImageView.bottomAnchor,
            right: nil,
            bottom: nil,
            left: nil,
            topPadding: 12,
            rightPadding: 0,
            bottomPadding: 0,
            leftPadding: 0,
            height: 21,
            width: 70)
        
        stackView.anchor(
            top: topAnchor,
            right: rightAnchor,
            bottom: nil,
            left: profilePictureImageView.leftAnchor,
            topPadding: 28,
            rightPadding: 10,
            bottomPadding: 0,
            leftPadding: 24,
            height: 40,
            width: 0)
        
        biographyTextView.anchor(
            top: stackView.bottomAnchor,
            right: rightAnchor,
            bottom: bottomAnchor,
            left: profilePictureImageView.leftAnchor,
            topPadding: 5,
            rightPadding: 10,
            bottomPadding: 10,
            leftPadding: 24,
            height: 69,
            width: 0)
        
    }
    
}
