//
//  CirclesActivityIndicatorView.swift
//  companion
//
//  Created by Uchenna  Aguocha on 10/22/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import UIKit

class CirclesLoadingView: UIView {
    
    // MARK: Properties
    
    var circlesLayer: [CAShapeLayer]?
    
    override func layoutSubviews() {
        backgroundColor = MakeSchoolDesignColor.faintBlue
        circlesLayer = createLayers(colors: MakeSchoolDesignColor.darkBlue)
    }
    
    func createLayers(colors: UIColor...) -> [CAShapeLayer] {
        
        let circleLayer = CAShapeLayer()
    
        for color in colors {
            circleLayer.fillColor = color.cgColor
            circleLayer.path = UIBezierPath(arcCenter: .zero, radius: 5, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true).cgPath
            circlesLayer?.append(circleLayer)
        }
        
        return circlesLayer ?? []
    }
    
    func startAnimating() {
        
    }
    
    func stopAnimating() {
        
    }
    
}
