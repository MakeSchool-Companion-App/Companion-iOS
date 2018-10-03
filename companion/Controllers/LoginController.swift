//
//  LoginController.swift
//  companion
//
//  Created by Uchenna  Aguocha on 9/27/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import UIKit

class LoginController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - UI Elements
    
    private let companionLabel: UILabel = {
        let label = UILabel()
        label.text = "Companion"
        label.textAlignment = .center
        label.font = UIFont.init(name: "AvenirNext-Bold", size: 40)
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return label
    }()
    
    private let emailTextField: UITextField = {
    
        let imageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 24, height: 24))
        imageView.image = #imageLiteral(resourceName: "Frame").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = #colorLiteral(red: 0.02745098039, green: 0.1215686275, blue: 0.7960784314, alpha: 1)
        
        let textField = LeftPaddedTextField()
        textField.leftView = imageView
        textField.leftView?.frame = CGRect(x: 20, y: 5, width: 24, height: 24)
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 10
        textField.attributedPlaceholder = NSAttributedString(string: "email address", attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.02745098039, green: 0.1215686275, blue: 0.7960784314, alpha: 1)])
        textField.textAlignment = .center
        textField.font = UIFont(name: "AvenirNext-Medium", size: 19)
        textField.backgroundColor = .white
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        imageView.image = #imageLiteral(resourceName: "lock").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = #colorLiteral(red: 0.02745098039, green: 0.1215686275, blue: 0.7960784314, alpha: 1)
        
        let textField = LeftPaddedTextField()
        textField.leftViewMode = .always
        textField.leftView = imageView
        textField.textAlignment = .center
        textField.layer.cornerRadius = 10
        textField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.02745098039, green: 0.1215686275, blue: 0.7960784314, alpha: 1)])
        textField.font = UIFont(name: "AvenirNext-Medium", size: 19)
        textField.backgroundColor = .white
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("login", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.02745098039, green: 0.1215686275, blue: 0.7960784314, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 24)
        button.backgroundColor = .white
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    // MARK: - View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(firstColor: #colorLiteral(red: 0.02745098039, green: 0.6, blue: 0.9333333333, alpha: 1), secondColor: #colorLiteral(red: 0.02745098039, green: 0.1215686275, blue: 0.7960784314, alpha: 1))
        setupAutoLayout()
        
    }
    
    // MARK: - Methods
    
    private func setupAutoLayout() {
        // Add Contraints to each subview
        
        emailTextField.anchor(top: nil, right: nil, bottom: nil, left: nil, topPadding: 0, rightPadding: 0, bottomPadding: 0, leftPadding: 0, height: 66, width: 290)

        passwordTextField.anchor(top: nil, right: nil, bottom: nil, left: nil, topPadding: 0, rightPadding: 0, bottomPadding: 0, leftPadding: 0, height: 66, width: 290)
        
        let textFieldStackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField])
        textFieldStackView.alignment = .center
        textFieldStackView.distribution = .equalSpacing
        textFieldStackView.axis = .vertical
        textFieldStackView.spacing = 16
        
        
        view.addSubviews(views: companionLabel, textFieldStackView, loginButton)
        
        companionLabel.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            bottom: nil,
            left: view.safeAreaLayoutGuide.leftAnchor,
            topPadding: 50,
            rightPadding: 73,
            bottomPadding: 0,
            leftPadding: 73,
            height: 48,
            width: 0)
        
        textFieldStackView.anchor(
            centerX: view.centerXAnchor,
            centerY: view.centerYAnchor,
            top: nil,
            right: view.safeAreaLayoutGuide.rightAnchor,
            bottom: nil,
            left: view.safeAreaLayoutGuide.leftAnchor,
            topPadding: 40,
            rightPadding: 0,
            bottomPadding: 0,
            leftPadding: 0,
            height: 177,
            width: 0)
        
        loginButton.anchor(
            centerX: view.centerXAnchor,
            centerY: nil,
            top: textFieldStackView.bottomAnchor,
            right: nil,
            bottom: nil,
            left: nil,
            topPadding: 80,
            rightPadding: 0,
            bottomPadding: 0,
            leftPadding: 0,
            height: 50,
            width: 180)
        
    }
    
    // MARK: Methods with @objc
    
    @objc private func handleLogin() {
        // After logging in, present the MainTabBarController

        let mainTabBarController = MainTabBarController()
        self.view.window?.rootViewController = mainTabBarController
        self.view.window?.makeKeyAndVisible()
    }
    
}

extension LoginController {
    
    
    
}
