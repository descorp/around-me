//
//  LocationService.swift
//  AroundMe
//
//  Created by Vladimir Abramichev on 07/08/2019.
//

import MapKit

class LocationService: NSObject, CLLocationManagerDelegate {
    
    lazy var currentLocation: CLLocationCoordinate2D = {
        let manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            manager.startUpdatingLocation()
        }
        
        return manager.location?.coordinate ?? coordinates
    }()
    
    let coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 52.313388, longitude: 5.037687)
}
