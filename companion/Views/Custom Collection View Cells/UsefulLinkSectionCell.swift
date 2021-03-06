//
//  UsefulLinkCell.swift
//  companion
//
//  Created by Uchenna  Aguocha on 11/14/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import UIKit

class UsefulLinkSectionCell: UITableViewCell {
    
    // MARK: Properties
    
    static let cellId = "UsefulLinkCellId"
    
    // MARK: UI Element
    
    let userLinkButton: UIButton = {
        let button = UIButton()
        button.setTitle("Useful Links", for: .normal)
        button.setTitleColor(MakeSchoolDesignColor.faintBlue, for: .normal)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 23)
        button.backgroundColor = MakeSchoolDesignColor.lightBlue
        return button
    }()
    
    // MARK: Initializers
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Layout Methods
    
    override func layoutSubviews() {
        backgroundColor = MakeSchoolDesignColor.faintBlue
        setupAutoLayout()
    }
    
    // MARK: Methods
    
    fileprivate func setupAutoLayout() {
        contentView.addSubview(userLinkButton)
        userLinkButton.anchor(top: contentView.topAnchor, right: contentView.rightAnchor, bottom: contentView.bottomAnchor, left: contentView.leftAnchor, topPadding: 20, rightPadding: 52, bottomPadding: 20, leftPadding: 52, height: 60, width: 0)
    }
    
}
