//
//  UserOnboardingViewController.swift
//  companion
//
//  Created by Medi Assumani on 1/17/19.
//  Copyright © 2019 Yves Songolo. All rights reserved.
//

import Foundation
import UIKit

class UserOnboardingViewController: UICollectionViewController{
    
    // - MARK: CLASS PROPERTIES
    
    // creates and styles the button to go backward
    let skipButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("SKIP", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(handleSkipButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    // creates and styles the button to go foward
    let nextButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleNextSwipe(_:)), for: .touchUpInside)
        button.backgroundColor = .gloomyBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.layer.shadowRadius = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    // creates and lays out the page controller
    lazy var pageControll: UIPageControl = {
        let pageController = UIPageControl()
        pageController.currentPage = 0
        pageController.numberOfPages = Constants.pages.count
        pageController.currentPageIndicatorTintColor = .gloomyBlue
        pageController.pageIndicatorTintColor = .gray
        return pageController
    }()
    
    // - MARK: VIEW CONTROLLER LIFECYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        collectionView?.isPagingEnabled =  true
        collectionView?.showsHorizontalScrollIndicator = false
        self.collectionView!.register(OnboardingCollectionCell.self, forCellWithReuseIdentifier: Constants.userOnboardingCellID)
        setUpButtonControls()
    }
    
    
    // - MARK: CLASS METHODS
    
    /// Swipes to the next page on the onboarding page
    @objc private func handleNextSwipe(_ sender: UIButton){
        
        let nextIndex = min(pageControll.currentPage + 1, Constants.pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControll.currentPage = nextIndex
        collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        sender.pulsate()
    }
    
    /// Skips to the user preferences page
    @objc private func handleSkipButton(_ sender: UIButton){
        
        sender.pulsate()
        
    }
    
    /// Configures and layout the skip, next button and the UIPager element
    private func setUpButtonControls(){
        
        let bottomControlsStackView = UIStackView(arrangedSubviews: [pageControll, nextButton, skipButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.axis = .vertical
        bottomControlsStackView.distribution = .fillEqually
        view.addSubview(bottomControlsStackView)
        
        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            bottomControlsStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
            //nextButton.widthAnchor.constraint(equalTo: bottomControlsStackView.widthAnchor, multiplier: 0.3),
//            nextButton.centerXAnchor.constraint(equalTo: bottomControlsStackView.centerXAnchor)
            //nextButton.heightAnchor.constraint(equalTo: bottomControlsStackView.heightAnchor, multiplier: 0.6),
//            pageControll.widthAnchor.constraint(equalTo: bottomControlsStackView.widthAnchor, multiplier: 0.3),
//            pageControll.heightAnchor.constraint(equalTo: bottomControlsStackView.heightAnchor, multiplier: 0.08)
            ])
    }
}
