//
//  LogHistoryCell.swift
//  companion
//
//  Created by Uchenna  Aguocha on 9/14/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit

class LogHistoryCell: UITableViewCell {
    
    static let logHistoryCellId = "LogHistoryCellId"
    
    // MARK: - UI Elements
    private let enterLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter"
        label.textColor = .blue
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir Next", size: 19)
        return label
    }()
    
    private let exitLabel: UILabel = {
        let label = UILabel()
        label.text = "Exit"
        label.textColor = .blue
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir Next", size: 19)
        return label
    }()
    
    let enterDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Sept 12, 2018 11:30am"
        label.textColor = .blue
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir Next", size: 16)
        return label
    }()
    
    let exitDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Sept 12, 2018 5:30pm"
        label.textColor = .blue
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir Next", size: 16)
        return label
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .blue
        setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAutoLayout() {
        
        // StackViews
        
        let enterStackView = UIStackView(arrangedSubviews: [enterLabel, enterDateLabel])
        enterStackView.axis = .vertical
        enterStackView.distribution = .fillProportionally
        enterStackView.alignment = .center
        
        let exitStackView = UIStackView(arrangedSubviews: [exitLabel, exitDateLabel])
        exitStackView.axis = .vertical
        exitStackView.distribution = .fillProportionally
        exitStackView.alignment = .center
        
        // Subviews
        
        contentView.addSubview(containerView)
        
        containerView.addSubviews(views: enterStackView, exitStackView)
        
        // Contraints
        
        containerView.anchor(
            top: contentView.topAnchor,
            right: contentView.rightAnchor,
            bottom: contentView.bottomAnchor,
            left: contentView.leftAnchor,
            topPadding: 10,
            rightPadding: 10,
            bottomPadding: 10,
            leftPadding: 10,
            height: 90,
            width: 0)
        
        enterStackView.anchor(
            top: containerView.topAnchor,
            right: nil,
            bottom: containerView.bottomAnchor,
            left: containerView.leftAnchor,
            topPadding: 11,
            rightPadding: 0,
            bottomPadding: 11,
            leftPadding: 16,
            height: 68,
            width: 150)
        
        exitStackView.anchor(
            top: containerView.topAnchor,
            right: containerView.rightAnchor,
            bottom: containerView.bottomAnchor,
            left: nil,
            topPadding: 11,
            rightPadding: 16,
            bottomPadding: 11,
            leftPadding: 0,
            height: 68,
            width: 150)
        
    }
    
}
