//
//  LocationManager.swift
//  Coffee
//
//  Created by Олег Ковалев on 11.02.2024.
//

import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    
    var coordinatesClosure: (((latitude: CLLocationDegrees, longitude: CLLocationDegrees)) -> Void)?
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            coordinatesClosure?((latitude, longitude))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}

