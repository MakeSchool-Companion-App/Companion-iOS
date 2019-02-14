//
//  CustomAlertView.swift
//  companion
//
//  Created by Uchenna  Aguocha on 2/12/19.
//  Copyright © 2019 Yves Songolo. All rights reserved.
//

import UIKit
/*
    Credit and recognition goes out to Aatish Rajkarnikar.
 Thanks for the code!! You can find his Medium article by searching this url: https://medium.com/@aatish.rajkarnikar/how-to-make-custom-alertview-dialogbox-with-animation-in-swift-3-2852f4e6f311
*/
protocol Modal {
    // MARK: - UI Components

    var backgroundView: UIView { get set }
    var dialogView: UIView { get set }

    // MARK: - Methods

    func show(animated:Bool)
    func dismiss(animated:Bool)
}

extension Modal where Self: UIView {
    func show(animated:Bool){
        self.backgroundView.alpha = 0
        self.dialogView.center = CGPoint(x: self.center.x, y: self.frame.height + self.dialogView.frame.height/2)
        UIApplication.shared.delegate?.window??.rootViewController?.view.addSubview(self)
        if animated {
            UIView.animate(withDuration: 0.33, animations: {
                self.backgroundView.alpha = 0.66
            })
            UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: {
                self.dialogView.center  = self.center
            }, completion: { (completed) in

            })
        }else{
            self.backgroundView.alpha = 0.66
            self.dialogView.center  = self.center
        }
    }

    func dismiss(animated:Bool){
        if animated {
            UIView.animate(withDuration: 0.33, animations: {
                self.backgroundView.alpha = 0
            }, completion: { (completed) in

            })
            UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: {
                self.dialogView.center = CGPoint(x: self.center.x, y: self.frame.height + self.dialogView.frame.height/2)
            }, completion: { (completed) in
                self.removeFromSuperview()
            })
        }else{
            self.removeFromSuperview()
        }

    }
}


class CustomAlertView: UIView, Modal {

    // MARK: - Properties


    // MARK: - UI Components

    var dialogView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        return view
    }()

    var backgroundView = UIView()
//        = {
//        let view = UIView()
//        view.frame = self.frame
//        view.backgroundColor = UIColor.black
//        view.alpha = 0.6
//        view.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
//        return view
//    }()

    var separatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = MakeSchoolDesignColor.faintGrey
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()

    let messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 17)
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.numberOfLines = 2
        return label
    }()

    let actionButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 17)
        button.setTitle("Okay", for: .normal)
        button.backgroundColor = MakeSchoolDesignColor.darkBlue
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
        return button
    }()


    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(title: String?, message: String?) {
        self.init(frame: UIScreen.main.bounds)

        backgroundView.frame = self.frame
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.6
        backgroundView.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        addSubview(backgroundView)
        
        setupAutoLayout(title: title, message: message)
    }


    // MARK: - Methods

    @objc func didTappedOnBackgroundView() {
        dismiss(animated: true)
    }

    @objc func didTapActionButton() {
        dismiss(animated: true)
    }
    
    fileprivate func setupAutoLayout(title: String?, message: String?) {
        titleLabel.text = title
        titleLabel.centerAnchor(centerX: nil, centerY: nil, width: 232, height: 27)
        separatorLineView.centerAnchor(centerX: nil, centerY: nil, width: 284, height: 2)
        messageLabel.text = message
        messageLabel.centerAnchor(centerX: nil, centerY: nil, width: 284, height: 64)

        let stackView = UIStackView(arrangedSubviews: [titleLabel, separatorLineView, messageLabel])
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 10

        dialogView.addSubview(stackView)
//        stackView.anchor(top: dialogView.topAnchor, right: dialogView.rightAnchor, bottom: nil, left: dialogView.leftAnchor)
        stackView.anchor(top: dialogView.topAnchor, right: dialogView.rightAnchor, bottom: nil, left: dialogView.leftAnchor, topPadding: 14, rightPadding: 0, bottomPadding: 0, leftPadding: 0, height: 0, width: 0)

        

        dialogView.addSubview(actionButton)
        actionButton.anchor(centerX: dialogView.centerXAnchor, centerY: nil, top: nil, right: nil, bottom: dialogView.bottomAnchor, left: nil, topPadding: 0, rightPadding: 0, bottomPadding: 14, leftPadding: 0, height: 41, width: 176)
        
        
        addSubview(dialogView)
        dialogView.anchor(
            centerX: self.centerXAnchor,
            centerY: self.centerYAnchor,
            top: nil,
            right: nil,
            bottom: nil,
            left: nil,
            topPadding: 0,
            rightPadding: 0,
            bottomPadding: 0,
            leftPadding: 0,
            height: 214,
            width: 312)
        

    }
}




