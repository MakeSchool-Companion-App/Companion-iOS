//
//  UsefulLinkCell.swift
//  companion
//
//  Created by Uchenna  Aguocha on 11/14/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import UIKit

class UsefulLinkCell: UITableViewCell {
    
    // MARK: Properties
    
    static let cellId = "UsefulLinkCellId"
    
    // MARK: UI Element
    
    let userLinkButton: UIButton = {
        let button = UIButton()
        button.setTitle("Useful Links", for: .normal)
        button.setTitleColor(MakeSchoolDesignColor.darkBlue, for: .normal)
        button.layer.cornerRadius = 6
        button.layer.borderColor = MakeSchoolDesignColor.darkBlue.cgColor
        button.layer.borderWidth = 2
        button.backgroundColor = MakeSchoolDesignColor.faintBlue
        return button
    }()
    
    // MARK: Initializers
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    fileprivate func setupAutoLayout() {
        contentView.addSubview(userLinkButton)
        userLinkButton.anchor(top: contentView.topAnchor, right: contentView.rightAnchor, bottom: contentView.bottomAnchor, left: contentView.leftAnchor, topPadding: 20, rightPadding: 25, bottomPadding: 20, leftPadding: 25, height: 70, width: 0)
    }
    
}
