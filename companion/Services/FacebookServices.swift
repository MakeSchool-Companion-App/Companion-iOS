//
//  FacebookServices.swift
//  companion
//
//  Created by Uchenna  Aguocha on 10/25/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import UIKit
import KeychainSwift

struct FacebookServices {
    
    
    // MARK: - Methods
    
    static func showFacebookUserProfile(completionHandler: @escaping (User?, Error?) -> Void) {
        
        
        let url = URL(string: "https://www.makeschool.com/login.json")
        let keychain = KeychainSwift()
        let session = URLSession.shared
        
        var request = URLRequest(url: url!)
        request.setValue("_makeschool_session=\(keychain.get("cookieValue")!)", forHTTPHeaderField: "Cookie")
        request.httpMethod = "POST"
        request.httpShouldHandleCookies = true
        
        session.dataTask(with: request) { (data, res, err) in
            
            do {
                guard let userData = data,
                    let decodedFacebookUser = try? JSONDecoder().decode(User.self, from: userData) else { return }
                
                completionHandler(decodedFacebookUser, nil)
            } catch let error {
                return completionHandler(nil, error)
            }
            
        }.resume()
    }
    
}
