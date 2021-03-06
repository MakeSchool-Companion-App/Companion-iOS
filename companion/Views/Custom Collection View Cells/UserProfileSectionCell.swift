//
//  UserProfileSectionCell.swift
//  companion
//
//  Created by Uchenna  Aguocha on 11/18/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit

class UserProfileSectionCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let cellId = "UserProfileCellId"
    
    var profile: Profile? {
        didSet {
            nameLabel.text = "\(profile?.first_name ?? "") \(profile?.last_name ?? "")"
            biographyTextView.text = profile?.about_description ?? ""
            concentrationLabel.text = profile?.professional_title ?? ""

            guard let imageUrl = URL(string: profile?.profile_img_url ?? "") else { return }

            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self.profilePictureImageView.image = UIImage(data: imageData)
                self.stopActivityIndicator()
            }
            
        }
    }

    // MARK: - UI Elements
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.activityIndicatorViewStyle = .gray
        return view
    }()
    
    let profilePictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = MakeSchoolDesignColor.faintBlue.cgColor
        
//        imageView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
//        imageView.layer.shadowOffset = CGSize.zero
//        imageView.layer.shadowOpacity = 0.25
//        imageView.layer.shadowRadius = 5
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = MakeSchoolDesignColor.black
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 23)
        return label
    }()
    
    let concentrationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = MakeSchoolDesignColor.darkGrey
        label.font = UIFont(name: "AvenirNext", size: 16)
        return label
    }()
    
    let biographyTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.textColor = MakeSchoolDesignColor.darkGrey
        textView.textAlignment = .left
        textView.font = UIFont(name: "AvenirNext-Medium", size: 13)
        textView.backgroundColor = .clear 
        textView.isEditable = false
        return textView
    }()
    
    let editButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.layer.cornerRadius = 6
        return button
    }()
    
    // MARK: - Initializer Methods 
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Layout Methods
    
    override func layoutSubviews() {
        setupAutoLayout()
        backgroundColor = MakeSchoolDesignColor.faintBlue
        startActivityIndicator()
    }
    
    // MARK: - Methods
    
    fileprivate func setupAutoLayout() {
        
        nameLabel.anchor(top: nil, right: nil, bottom: nil, left: nil, topPadding: 0, rightPadding: 0, bottomPadding: 0, leftPadding: 0, height: 24, width: 0)
        concentrationLabel.anchor(top: nil, right: nil, bottom: nil, left: nil, topPadding: 0, rightPadding: 0, bottomPadding: 0, leftPadding: 0, height: 20, width: 0)
        biographyTextView.anchor(top: nil, right: nil, bottom: nil, left: nil, topPadding: 0, rightPadding: 0, bottomPadding: 0, leftPadding: 0, height: 70, width: 0)
        
        let rightHandSideStackView = UIStackView(arrangedSubviews: [nameLabel, concentrationLabel, biographyTextView])
        rightHandSideStackView.distribution = .equalSpacing
        rightHandSideStackView.axis = .vertical
        rightHandSideStackView.alignment = .fill
        rightHandSideStackView.spacing = 1
        
        rightHandSideStackView.anchor(top: nil, right: nil, bottom: nil, left: nil, topPadding: 0, rightPadding: 0, bottomPadding: 0, leftPadding: 0, height: 0, width: 0)
        
        profilePictureImageView.anchor(top: nil, right: nil, bottom: nil, left: nil, topPadding: 0, rightPadding: 0, bottomPadding: 0, leftPadding: 0, height: 95, width: 95)
        profilePictureImageView.layer.cornerRadius = 90 / 2
        
        let mainStackView = UIStackView(arrangedSubviews: [profilePictureImageView, rightHandSideStackView])
        mainStackView.distribution = .fillProportionally
        mainStackView.axis = .horizontal
        mainStackView.alignment = .center
        mainStackView.spacing = 10
        
        contentView.addSubview(mainStackView)
        
        mainStackView.anchor(top: contentView.topAnchor, right: contentView.rightAnchor, bottom: contentView.bottomAnchor, left: contentView.leftAnchor, topPadding: 0, rightPadding: 10, bottomPadding: 10, leftPadding: 10, height: 0, width: 0)
        
        
        
    }
    
    
    private func startActivityIndicator() {
        DispatchQueue.main.async {
            self.contentView.addSubview(self.activityIndicatorView)
            self.activityIndicatorView.frame = self.contentView.bounds
            self.activityIndicatorView.center = self.contentView.center
            self.activityIndicatorView.hidesWhenStopped = true
            self.activityIndicatorView.startAnimating()
            //            UIApplication.shared.beginIgnoringInteractionEvents()
        }
    }
    
    private func stopActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            self.activityIndicatorView.removeFromSuperview()
            //            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
}
