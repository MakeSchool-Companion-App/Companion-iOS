//
//  RegionProtocol.swift
//  companion
//
//  Created by Yves Songolo on 2/6/19.
//  Copyright © 2019 Yves Songolo. All rights reserved.
//

import Foundation
import CoreLocation


protocol RegionProtocol {
    //    var coordinate: CLLocation {get}
    //    var radius: CLLocationDistance {get}
    //    var identifier: String {get}

    func updateRegion(region: CKSquareRegion, location: CLLocation, squareRegionDelegate: RegionDelegateProtocol)

}

extension RegionProtocol{
    /// Method to check wether the user user walk in or out of the square region
    func updateRegion(region: CKSquareRegion, location: CLLocation, squareRegionDelegate: RegionDelegateProtocol){

        let distance = location.distance(from: CLLocation.init(latitude: region.center.latitude, longitude: region.center.longitude))
        if (region.contains(location.coordinate)){
            print( " inside the square at distance: \(distance)")

            let defaults = UserDefaults.standard
            if let inSide = defaults.value(forKey: "inside") as? Bool {

                if !inSide{
                    squareRegionDelegate.didEnterRegion(region: region)
                    defaults.set(true, forKey: "inside")
                }
            }
            else{
                squareRegionDelegate.didEnterRegion(region: region)
                defaults.set(true, forKey: "inside")
            }

        }
        else{
            print("out side the square at distance: \(distance)")
            let defaults = UserDefaults.standard
            if let inSide = defaults.value(forKey: "inside") as? Bool {
                if inSide{
                    squareRegionDelegate.didExitRegion(region: region)
                    defaults.set(false, forKey: "inside")
                }
            }
            else{
                squareRegionDelegate.didExitRegion(region: region)
                defaults.set(false, forKey: "inside")
            }


        }
    }
}
