//
//  GeofenceServices.swift
//  companion
//
//  Created by Yves Songolo on 10/2/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import CoreLocation

struct GeoFenceServices{
    
    
    /// method to convert address to coordinate
    private static func addressToCoordinate(_ address: String, completion: @escaping(CLLocationCoordinate2D?)->()){
        print("getting location coordinate")
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            placemarks, error in
            
            if error != nil {return completion(nil)}
            
            let placemark = placemarks?.first
            let lat = placemark?.location?.coordinate.latitude
            let lon = placemark?.location?.coordinate.longitude
            guard let longitude = lon, let latitutde = lat else {return completion(nil)}
            print("location: lat: \(latitutde) lon: \(longitude)")

            return completion(CLLocationCoordinate2D(latitude: latitutde, longitude: longitude))
            
        }
    }
    /// Mehtod to start monitoring region
    static func startMonitoringMakeschool( completion: @escaping (Bool)->()){
        //let address = "555 post street, San Francisco, CA"
       // let testAddress = "1368 natoma street, San Francisco, CA"
        //addressToCoordinate(address) { (center) in
            
            let center = CLLocationCoordinate2D.init(latitude: 37.787690, longitude: -122.410930)

            let testCenter = CLLocationCoordinate2D.init(latitude: 37.703026, longitude: -121.759735)
        
            let squareRegion = CKSquareRegion.init(regionWithCenter: testCenter, sideLength: 50, identifier: Constants.makeSchoolRegionId)
                //squareRegion?.notifyOnExit = true
                //squareRegion?.notifyOnEntry = true


            let region = CLCircularRegion(center: center, radius: 30, identifier: Constants.makeSchoolRegionId)
            region.notifyOnExit = true
            region.notifyOnEntry = true
            let manager = AppDelegate.shared.locationManager//CLLocationManager()
            //manager.startMonitoring(for: squareRegion!)
            manager.startMonitoring(for: region)
            return completion(true)
        //}
        
       
       
    }
    
}










