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
        imageView.image = UIImage(named: "uchennagithub")
        imageView.frame = CGRect(x: 0, y: 0, width: 95, height: 95)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = MakeSchoolDesignColor.faintBlue.cgColor
//        imageView.layer.shadowColor = MakeSchoolDesignColor.black.cgColor
//        imageView.layer.shadowRadius = 45.25
//        imageView.layer.shadowOpacity = 0.5
//        imageView.layer.shadowOffset = CGSize(width: 100, height: 100)
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Uchenna Aguocha"
        label.textAlignment = .left
        label.textColor = MakeSchoolDesignColor.black
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 23)
        return label
    }()
    
    let concentrationLabel: UILabel = {
        let label = UILabel()
        label.text = "Mobile Developer"
        label.textAlignment = .left
        label.textColor = MakeSchoolDesignColor.darkGrey
        label.font = UIFont(name: "AvenirNext", size: 16)
        return label
    }()
    
    let biographyTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.text = "Senior iOS Developer @ Make School. I enjoy sleeping, biking, running, and eating free food."
        textView.textColor = MakeSchoolDesignColor.darkGrey
        textView.textAlignment = .left
        textView.backgroundColor = UIColor.clear
        textView.font = UIFont(name: "AvenirNext-Medium", size: 13)
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
        
        profilePictureImageView.anchor(
            top: nil,
            right: nil,
            bottom: nil,
            left: nil,
            topPadding: 0,
            rightPadding: 0,
            bottomPadding: 0,
            leftPadding: 0,
            height: 0,
            width: 0)
        
        editButton.anchor(
            centerX: nil,
            centerY: nil,
            top: nil,
            right: nil,
            bottom: nil,
            left: nil,
            topPadding: 0,
            rightPadding: 0,
            bottomPadding: 0,
            leftPadding: 0,
            height: 25,
            width: 70)
        
        let leftStackView = UIStackView(arrangedSubviews: [profilePictureImageView, editButton])
        leftStackView.distribution = .equalSpacing
        leftStackView.axis = .vertical
        leftStackView.alignment = .center
        leftStackView.spacing = 10

        
        
        nameLabel.anchor(top: nil, right: nil, bottom: nil, left: nil, topPadding: 0, rightPadding: 0, bottomPadding: 0, leftPadding: 0, height: 23, width: 0)
        concentrationLabel.anchor(top: nil, right: nil, bottom: nil, left: nil, topPadding: 0, rightPadding: 0, bottomPadding: 0, leftPadding: 0, height: 15, width: 0)
        biographyTextView.anchor(top: nil, right: nil, bottom: nil, left: nil, topPadding: 0, rightPadding: 0, bottomPadding: 0, leftPadding: 0, height: 0, width: 0)
        
        let rightStackView = UIStackView(arrangedSubviews: [nameLabel, concentrationLabel, biographyTextView])
        rightStackView.distribution = .fillProportionally
        rightStackView.axis = .vertical
        rightStackView.alignment = .leading
        rightStackView.spacing = 0
        
        addSubviews(views: leftStackView, rightStackView)
        
        leftStackView.anchor(top: topAnchor, right: nil, bottom: bottomAnchor, left: leftAnchor, topPadding: 10, rightPadding: 0, bottomPadding: 10, leftPadding: 10, height: 0, width: 95)
        
        rightStackView.anchor(top: topAnchor, right: rightAnchor, bottom: bottomAnchor, left: leftStackView.rightAnchor, topPadding: 20, rightPadding: 0, bottomPadding: 10, leftPadding: 10, height: 0, width: 0)


        
    }
    
}
