//
//  BeaconView.swift
//  companion
//
//  Created by Uchenna  Aguocha on 9/14/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit

class BeaconView: UIView {
    
    // MARK: - Properties
    
    var topLayer: CAShapeLayer!
//    var secondLayer: CAShapeLayer!
    
    // MARK: - UI Elements
    
    lazy var beaconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.image = #imageLiteral(resourceName: "ibeacon_white")
        return imageView
    }()
    
    let topView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 160, height: 160)
        view.layer.cornerRadius = view.frame.size.height / 2
        view.backgroundColor = .blue
        return view
    }()
    
    let secondView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 21/255, green: 115/255, blue: 247/255, alpha: 1)
        view.frame = CGRect(x: 0, y: 0, width: 190, height: 190)
        view.layer.cornerRadius = view.frame.size.height / 2
        return view
    }()
    
    let baseView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 224, height: 224)
        view.layer.cornerRadius = view.frame.size.height / 2 
        view.backgroundColor = UIColor(red: 84/255, green: 155/255, blue: 255/255, alpha: 0.58)
        return view
    }()
    
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func setupViews() {
    
    }
    
    private func setupAutoLayout() {
        
        addSubviews(views: baseView, secondView, beaconImageView)
        baseView.centerAnchor(
            centerX: self.centerXAnchor,
            centerY: self.centerYAnchor,
            width: 224,
            height: 224)
        
        insertSubview(secondView, aboveSubview: baseView)
        secondView.centerAnchor(
            centerX: self.centerXAnchor,
            centerY: self.centerYAnchor,
            width: 190,
            height: 190)
        
        insertSubview(topView, aboveSubview: secondView)
        topView.centerAnchor(
            centerX: self.centerXAnchor,
            centerY: self.centerYAnchor,
            width: 160,
            height: 160)
        
        insertSubview(beaconImageView, aboveSubview: topView)
        beaconImageView.centerAnchor(
            centerX: self.centerXAnchor,
            centerY: self.centerYAnchor,
            width: 140,
            height: 140)
        
        
    }
    
    func startPulsatingAnimation() {
       
        addPulsatingAnimation(toView: baseView, value: 1.3, duration: 0.8)
        addPulsatingAnimation(toView: secondView, value: 1.2, duration: 0.8)
//        secondView.layer.add(animation, forKey: "pulsing")
    }
    
    private func addPulsatingAnimation(toView view: UIView, value: CGFloat, duration: Double) {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        
        animation.toValue = value
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        
        view.layer.add(animation, forKey: "pulsing")
    }
    
    func stopPulsatingAnimation() {
        
    }
    
    func checkMarkAnimation() {
        startPulsatingAnimation()
        
        insertSubview(beaconImageView, aboveSubview: topView)
        beaconImageView.centerAnchor(
            centerX: self.centerXAnchor,
            centerY: self.centerYAnchor,
            width: 86,
            height: 60)
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: [.curveEaseIn, .transitionCurlUp],
            animations: {
                self.beaconImageView.image = #imageLiteral(resourceName: "checkmark")
                self.beaconImageView.backgroundColor = .clear
                
//                self.beaconImageView.transform = CGAffineTransform.init().rotated(by: CGFloat(Double.pi))
//                self.beaconImageView.transform = CGAffineTransform.init()
                self.topView.backgroundColor = .white
                
            },
            completion: nil)
        
        
    }
    

}
