//
//  OnboardingController.swift
//  companion
//
//  Created by Uchenna  Aguocha on 9/28/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import UIKit

class OnboardingController: UICollectionViewController {
    
    // MARK: - Properties
    
    let pages: [Page] = [
        Page(image: "", headerText: "", bodyText: ""),
        Page(image: "", headerText: "", bodyText: "Companion uses an iBeacon and your location to keep track of your attendance. "),
        Page(image: "" , headerText: "", bodyText: "You will be able see when you walked inside and outside of school ")
    ]
    
    // MARK: - UI Elements
    
    private let previousButton: UIButton = {
        let button = UIButton()
        button.setTitle("Previous", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 17)
        button.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 17)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.currentPage = 0
        control.numberOfPages = 3
        control.currentPageIndicatorTintColor = #colorLiteral(red: 0.03529411765, green: 0.1607843137, blue: 0.8078431373, alpha: 1)
        control.pageIndicatorTintColor = #colorLiteral(red: 0.1764705882, green: 0.5607843137, blue: 0.9215686275, alpha: 1)
        return control
    }()
    
    
    // MARK: - View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBottomControls()
        setupCollectionView()
        
    }
    
    
    // MARK: - Methods
    
    fileprivate func setupCollectionView() {

        collectionView?.backgroundColor = .gray
        collectionView?.register(OnboardingCollectionCell.self, forCellWithReuseIdentifier: OnboardingCollectionCell.onboardingCellID)
        collectionView?.isPagingEnabled = true
    }
    
    fileprivate func setupBottomControls() {
        
        // Setup the bottom control (previousButton, pageControl, & nextButton) as a subview and add constraints
        
        // Add bottom control in a stack view
        let bottomControlStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        bottomControlStackView.distribution = .fillEqually
        bottomControlStackView.axis = .horizontal
        // Add Subview
        view.addSubview(bottomControlStackView)
        
        //Add Constraints
        bottomControlStackView.anchor(
            top: nil,
            right: view.safeAreaLayoutGuide.rightAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            topPadding: 0,
            rightPadding: 0,
            bottomPadding: 0,
            leftPadding: 0,
            height: 50,
            width: 0)
    }
    
    private func setupAutoLayout() {
        
    }
    
    @objc private func handlePrevious() {
        let prevIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: prevIndex, section: 0)
        
        pageControl.currentPage = prevIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func handleNext() {
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        
        if pageControl.currentPage == 1 {
            nextButton.setTitle("Get Started", for: .normal)
            
        }
        
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        print("Next Index: \(nextIndex)")
    }
    
}

//MARK: - CollectionView Delegate & DataSource

extension OnboardingController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionCell.onboardingCellID, for: indexPath) as? OnboardingCollectionCell
        else {
            fatalError("Failed to create initialize oboardingCell instance")
        }
        let page = pages[indexPath.row]
        
        cell.thumbnailImageView.image = UIImage(named: page.image)
        cell.descriptionTextView.text = page.bodyText
        
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

// MARK: - ScrollView Delegate Methods
extension OnboardingController {
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x/view.frame.width)
        
    }
}
