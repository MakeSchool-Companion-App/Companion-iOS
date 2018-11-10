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
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.activityIndicatorViewStyle = .gray
        return view
    }()
    
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
    
    private var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(MakeSchoolDesignColor.faintBlue, for: .normal)
        button.backgroundColor = MakeSchoolDesignColor.darkBlue
        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 17)
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private var facebookLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login with Facebook", for: .normal)
        button.setTitleColor(MakeSchoolDesignColor.faintBlue, for: .normal)
        button.backgroundColor = UIColor(r: 59, g: 89, b: 152, a: 1)
        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 17)
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(handleFacebookLogin), for: .touchUpInside)
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
        
        // dismiss keyboard on touch
        self.hideKeyboard()
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
        
        
        
        
        view.addSubviews(views: companionLabel, textFieldStackView, loginButton, facebookLoginButton)
        
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
            topPadding: 42,
            rightPadding: 0,
            bottomPadding: 0,
            leftPadding: 0,
            height: 46,
            width: 206)
        
        facebookLoginButton.anchor(
            centerX: view.centerXAnchor,
            centerY: nil,
            top: loginButton.bottomAnchor,
            right: nil,
            bottom: nil,
            left: nil,
            topPadding: 30,
            rightPadding: 0,
            bottomPadding: 0,
            leftPadding: 0,
            height: 46,
            width: 206)
        
//        loginButton.anchor(
//            centerX: view.centerXAnchor,
//            centerY: nil,
//            top: textFieldStackView.bottomAnchor,
//            right: nil,
//            bottom: nil,
//            left: nil,
//            topPadding: 80,
//            rightPadding: 0,
//            bottomPadding: 0,
//            leftPadding: 0,
//            height: 50,
//            width: 180)
        
    }
    
    private func startActivityIndicator() {
        DispatchQueue.main.async {
            self.view.addSubview(self.activityIndicatorView)
            self.activityIndicatorView.frame = self.view.bounds
            self.activityIndicatorView.center = self.view.center
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
    
    // MARK: Methods with @objc
    
    @objc private func handleLogin() {
        // After logging in, present the MainTabBarController
        
        guard let email = emailTextField.text,
              let password = passwordTextField.text
        else { return }
        
        print("Password: \(password)")
        startActivityIndicator()
        UserServices.login(email: email, password: password) { (user) in
            
            
            
            if let user = user as? User {
                // handle existing user
                User.setCurrent(user, writeToUserDefaults: true)
                self.stopActivityIndicator()

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
    
    @objc private func handleFacebookLogin() {
        print("LOGIN WITH FACEBOOK")
        let defaults = UserDefaults.standard
        let initialViewController: UIViewController
        
        if let _ = User.current,
            let userData = defaults.object(forKey: Constants.current) as? Data,
            let user = try? JSONDecoder().decode(User.self, from: userData) {
            
            User.setCurrent(user)
            initialViewController = MainTabBarController()
        } else {
            initialViewController = FacebookLoginWebViewController()
        }
        
        view.window?.rootViewController = initialViewController
        view.window?.makeKeyAndVisible()
//        DispatchQueue.main.async {
//            let faceBookLoginWebViewController = FacebookLoginWebViewController()
//            self.view.window?.rootViewController = faceBookLoginWebViewController
//            self.view.window?.makeKeyAndVisible()
//        }
    }
    
//    let defualts = UserDefaults.standard
//    let initialViewController: UIViewController
//
//
//    if let _ = User.current,
//    let userData = defualts.object(forKey: Constants.current) as? Data,
//    let user = try? JSONDecoder().decode(User.self, from: userData) {
//
//        User.setCurrent(user)
//        initialViewController = MainTabBarController()
//    } else {
//    initialViewController = LoginController()
//    }
//
//    window?.rootViewController = initialViewController
//    window?.makeKeyAndVisible()
    
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



