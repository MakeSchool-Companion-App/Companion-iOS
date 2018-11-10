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
    
    var user: User?
    
    // MARK: - UI Elements
    
    private let companionLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to Companion!"
        label.textAlignment = .left
        label.font = UIFont.init(name: "AvenirNext-DemiBold", size: 33)
        label.numberOfLines = 2
        label.textColor = MakeSchoolDesignColor.black
        return label
    }()
    
    private let emailTextField: UITextField = {
        // MARK: TODO - Add padding to the image
//        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
//        leftView.backgroundColor = MakeSchoolDesignColor.faintBlue
//        
//        let imageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 24, height: 24))
//        imageView.image = #imageLiteral(resourceName: "Frame").withRenderingMode(.alwaysTemplate)
//        imageView.tintColor = MakeSchoolDesignColor.darkBlue
//        
//        leftView.addSubview(imageView)
        
        let textField = LeftPaddedTextField()
//        textField.leftView = leftView
//        textField.setLeftPaddingPoints()
//        textField.leftView?.frame = CGRect(x: 20, y: 5, width: 24, height: 24)
        textField.leftViewMode = .always
        textField.textColor = MakeSchoolDesignColor.darkBlue
        textField.layer.cornerRadius = 6
        textField.layer.shadowColor = #colorLiteral(red: 0.03137254902, green: 0.4862745098, blue: 0.7215686275, alpha: 1).cgColor
        textField.layer.shadowOffset = CGSize.zero
        textField.layer.shadowOpacity = 0.40
        textField.layer.shadowRadius = 5
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedStringKey.foregroundColor: MakeSchoolDesignColor.darkBlue])
        textField.textAlignment = .left
        textField.font = UIFont(name: "AvenirNext-DemiBold", size: 17)
        textField.becomeFirstResponder()
        textField.isUserInteractionEnabled = true
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        textField.backgroundColor = MakeSchoolDesignColor.faintBlue
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        // MARK: TODO - Uchenna Add padding to the image
//        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
//        leftView.backgroundColor = MakeSchoolDesignColor.faintBlue
//
//        let imageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 24, height: 24))
//        imageView.image = #imageLiteral(resourceName: "lock").withRenderingMode(.alwaysTemplate)
//        imageView.tintColor = MakeSchoolDesignColor.darkBlue
//
//        leftView.addSubview(imageView)
        
        let textField = LeftPaddedTextField()
        textField.leftViewMode = .always
//        textField.leftView = leftView
        
        textField.textAlignment = .left
        textField.textColor = MakeSchoolDesignColor.darkBlue
        textField.backgroundColor = MakeSchoolDesignColor.faintBlue
        textField
        textField.layer.cornerRadius = 6
        textField.layer.shadowColor = #colorLiteral(red: 0.03137254902, green: 0.4862745098, blue: 0.7215686275, alpha: 1).cgColor
        textField.layer.shadowOffset = CGSize.zero
        textField.layer.shadowOpacity = 0.40
        textField.layer.shadowRadius = 5
        
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor: MakeSchoolDesignColor.darkBlue])
        textField.font = UIFont(name: "AvenirNext-DemiBold", size: 17)
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(MakeSchoolDesignColor.faintBlue, for: .normal)
        button.backgroundColor = MakeSchoolDesignColor.darkBlue
        button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 24)
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    // MARK: - View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MakeSchoolDesignColor.faintBlue
        setupAutoLayout()
        
        emailTextField.delegate = self
        emailTextField.becomeFirstResponder()
        
        passwordTextField.delegate = self 
        
    }
    
    // MARK: - Methods
    
    private func setupAutoLayout() {
        // Add Contraints to each subview
        
        emailTextField.anchor(top: nil, right: nil, bottom: nil, left: nil, topPadding: 0, rightPadding: 0, bottomPadding: 0, leftPadding: 0, height: 60, width: 300)

        passwordTextField.anchor(top: nil, right: nil, bottom: nil, left: nil, topPadding: 0, rightPadding: 0, bottomPadding: 0, leftPadding: 0, height: 60, width: 300)
        
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
            leftPadding: 36,
            height: 100,
            width: 225)
        
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
        
        guard let email = emailTextField.text,
              let password = passwordTextField.text
        else { return }
        
        UserServices.login(email: email, password: password) { (user) in
            
            
            if let user = user as? User {
                // handle existing user
                User.setCurrent(user, writeToUserDefaults: true)
                
                DispatchQueue.main.async {
                    let mainTabBarController = MainTabBarController()
                    self.view.window?.rootViewController = mainTabBarController
    
                    self.view.window?.makeKeyAndVisible()
                }
                
            } else {
                self.presentAlert(title: "", message: "Incorrect email or password")
            }
            
        }
        
        
        
    }
    
}

extension LoginController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("show keyboard")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

}


extension LoginController {
    
//    func loginUser(_ email: String, _ password: String) {
//        UserServices.login(email: email, password: password) { (user) in
//            if let user = user as? User{
//                User.setCurrent(user, writeToUserDefaults: true)
//                // perform segue
//            }
//            else{
//                // error message
//            }
//        }
//    }
//
    
}
