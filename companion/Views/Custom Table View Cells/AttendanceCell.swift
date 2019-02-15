//
//  AttendanceCell.swift
//  companion
//
//  Created by Uchenna  Aguocha on 9/28/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit

class AttendanceCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let attendanceCellId = "attendanceCellId"
    
    // MARK: - UI Elements
    
    private let checkInLabel: UILabel = {
        let label = UILabel()
        label.text = "Check in"
        label.textColor = MakeSchoolDesignColor.mediumBlue
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Heavy", size: 22)
        return label
    }()
    
    let checkInTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "9:30am"
        label.textColor = MakeSchoolDesignColor.black
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Light", size: 17)
        return label
    }()
    
    let checkInDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Sept 3, 2018"
        label.textColor = MakeSchoolDesignColor.black
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Light", size: 17)
        return label
    }()
    
    private let checkOutLabel: UILabel = {
        let label = UILabel()
        label.text = "Check out"
        label.textColor = MakeSchoolDesignColor.mediumBlue
        label.textAlignment = .right
        label.font = UIFont(name: "Avenir-Heavy", size: 22)
        return label
    }()
    
    let checkOutTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "5:30pm"
        label.textColor = MakeSchoolDesignColor.black
        label.textAlignment = .right
        label.font = UIFont(name: "Avenir-Light", size: 17)
        return label
    }()
    
    let checkOutDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Sept 3, 2018"
        label.textColor = MakeSchoolDesignColor.black
        label.textAlignment = .right
        label.font = UIFont(name: "Avenir-Light", size: 17)
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
//        view.backgroundColor = #colorLiteral(red: 0.8862745098, green: 0.9137254902, blue: 0.9725490196, alpha: 1)
        view.backgroundColor = #colorLiteral(red: 0.8862745098, green: 0.9137254902, blue: 0.9725490196, alpha: 1)
        view.layer.shadowOpacity = 0.1
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 15)
        view.layer.shadowRadius = 8
        view.layer.shouldRasterize = false
        view.layer.cornerRadius = 5
        return view
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9019607843, blue: 0.9607843137, alpha: 1)
        setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupAutoLayout() {
        
        let checkInStackView = UIStackView(arrangedSubviews: [checkInLabel, checkInTimeLabel, checkInDateLabel])
        checkInStackView.axis = .vertical
        checkInStackView.alignment = .leading
        checkInStackView.distribution = .fillProportionally
        
        let checkOutStackView = UIStackView(arrangedSubviews: [checkOutLabel, checkOutTimeLabel, checkOutDateLabel])
        checkOutStackView.axis = .vertical
        checkOutStackView.alignment = .trailing
        checkOutStackView.distribution = .fillProportionally
        
        contentView.addSubview(containerView)
        
        containerView.anchor(
            top: contentView.topAnchor,
            right: contentView.rightAnchor,
            bottom: contentView.bottomAnchor,
            left: contentView.leftAnchor,
            topPadding: 10,
            rightPadding: 16,
            bottomPadding: 10,
            leftPadding: 16,
            height: 0,
            width: 0)
        
        containerView.addSubviews(views: checkInStackView, checkOutStackView)
        
        checkInStackView.anchor(
            top: containerView.topAnchor,
            right: nil,
            bottom: containerView.bottomAnchor,
            left: containerView.leftAnchor,
            topPadding: 10,
            rightPadding: 0,
            bottomPadding: 10,
            leftPadding: 10,
            height: 68,
            width: 127)
        
        checkOutStackView.anchor(
            top: containerView.topAnchor,
            right: containerView.rightAnchor,
            bottom: containerView.bottomAnchor,
            left: nil,
            topPadding: 10,
            rightPadding: 10,
            bottomPadding: 10,
            leftPadding: 0,
            height: 68,
            width: 127)
        
        
    }
    
}
