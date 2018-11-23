//
//  StaticLinksCell.swift
//  companion
//
//  Created by Uchenna  Aguocha on 11/17/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit

class StaticLinksCell: UITableViewCell {
    
    // MARK: Properties
    
    static let cellId = "StaticLinksCellId"
    
    // MARK: UI Elements
    
    let linkLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Medium", size: 17)
        return label
    }()
    
    // MARK: Initializers
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Layout Methods
    
    override func layoutSubviews() {
        setupAutoLayout()
    }
    
    // MARK: Methods
    
    private func setupAutoLayout() {
        contentView.addSubview(linkLabel)
        linkLabel.centerAnchor(centerX: contentView.centerXAnchor, centerY: contentView.centerYAnchor, width: 200, height: 50)
    }

}
