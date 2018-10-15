//
//  LeftPaddedTextField.swift
//  companion
//
//  Created by Uchenna  Aguocha on 10/1/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit

class LeftPaddedTextField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10,
                      y: bounds.origin.y,
                      width: bounds.width,
                      height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10,
                      y: bounds.origin.y,
                      width: bounds.width,
                      height: bounds.height)
    }
    
}
