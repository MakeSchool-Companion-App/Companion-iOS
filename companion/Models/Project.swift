//
//  Projects.swift
//  companion
//
//  Created by Uchenna  Aguocha on 10/20/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import UIKit

struct Project: Codable {
    let name: String
    let technologies: String
    //let image: UIImage
    let img_url: String
    var writeup_url: String?
    var github_url: String?
    var uri: String?
    let id: Int
    var description: String?
}
