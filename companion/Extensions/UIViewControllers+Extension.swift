//
//  viewControllers.swift
//  Linner
//
//  Created by Yves Songolo on 8/23/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func presentAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        alert.addAction(cancel)
        self.present(alert,animated: true)
    }
    
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}

