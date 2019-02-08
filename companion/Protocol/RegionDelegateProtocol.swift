//
//  RegionDelegateProtocol.swift
//  companion
//
//  Created by Yves Songolo on 2/6/19.
//  Copyright © 2019 Yves Songolo. All rights reserved.
//

import Foundation

protocol RegionDelegateProtocol {
    func didEnterRegion(region: CKSquareRegion)
    func didExitRegion(region: CKSquareRegion)
}
