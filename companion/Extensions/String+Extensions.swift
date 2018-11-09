//
//  String+Extensions.swift
//  financeApp
//
//  Created by Yves Songolo on 8/27/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = formatter.date(from: self) else {return nil}
        return date
    }
    
    var convertToMonthDayYear: Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy"
        guard let date = dateFormatter.date(from: self) else { return Date() }
        
        return date
    }
    
    var timeToDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm a"
        guard let time = dateFormatter.date(from: self) else { return Date() }
        
        return time 
    }
}
