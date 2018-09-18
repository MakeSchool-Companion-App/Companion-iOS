//
//  ScanBeaconController.swift
//  companion
//
//  Created by Uchenna  Aguocha on 9/12/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit

class ScanBeaconController: UIViewController {

    
    // MARK: - Properties
    
    // will this later. Only for testing purposes
    private let urlString = "https://firebasestorage.googleapis.com/v0/b/firestorechat-e64ac.appspot.com/o/intermediate_training_rec.mp4?alt=media&token=e20261d0-7219-49d2-b32d-367e1606500c"
    
    // MARK: - UI Elements
    
    let beaconView = BeaconView()
    
    let searchForBeaconLabel: UILabel = {
        let label = UILabel()
        label.text = "Searching for iBeacon..."
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        
        return label
    }()
    
    let cancelAndOkButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(showHistory), for: .touchUpInside)
        return button
    }()
    

    // MARK: - View Life Cyle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 53/255, green: 65/255, blue: 164/255, alpha: 1)
        print(beaconView.frame)
        
        beaconView.startPulsatingAnimation()
//       beginDownloadingFile()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupAutoLayout()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        beaconView.checkMarkAnimation()
//        searchForBeaconLabel.text = "iBeacon Found"
//        cancelAndOkButton.setTitle("Okay", for: .normal)
//
//    }

    
    // MARK: - Methods
    
    func setupAutoLayout() {

        view.addSubviews(views: beaconView, searchForBeaconLabel, cancelAndOkButton)

        beaconView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            bottom: nil,
            left: view.safeAreaLayoutGuide.leftAnchor,
            topPadding: 0,
            rightPadding: 0,
            bottomPadding: 0,
            leftPadding: 0,
            height: 300,
            width: 0)
        
        searchForBeaconLabel.anchor(
            top: beaconView.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            bottom: nil,
            left: view.safeAreaLayoutGuide.leftAnchor,
            topPadding: 30,
            rightPadding: 20,
            bottomPadding: 0,
            leftPadding: 20,
            height: 65,
            width: 0)
        
        cancelAndOkButton.anchor(
            top: nil,
            right: nil,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            left: nil,
            topPadding: 60,
            rightPadding: 0,
            bottomPadding: 0,
            leftPadding: 0,
            height: 65,
            width: 224)
        cancelAndOkButton.centerAnchor(centerX: view.centerXAnchor, centerY: nil)
        
    }
    
    func beginDownloadingFile() {
        print("Attempting to download...")
        let configuration = URLSessionConfiguration.default
        let operationQueue = OperationQueue()
        let urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: operationQueue)
        
        guard let url = URL(string: urlString) else { return }
        let downloadTask = urlSession.downloadTask(with: url)
        downloadTask.resume()
    }
    
    @objc private func showHistory() {
        print("Show Check In & Out History")
        let logHistoryController = LogHistoryController()
        show(logHistoryController, sender: nil)
    }
}

extension ScanBeaconController: URLSessionDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        print("Finished downloading file")
        
        
    }
}
