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
        let cancel = UIAlertAction(title: "Return", style: .cancel, handler: nil)
        alert.addAction(cancel)
        self.present(alert,animated: true)
    }
}
