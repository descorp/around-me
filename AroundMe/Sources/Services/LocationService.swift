//
//  LocationService.swift
//  AroundMe
//
//  Created by Vladimir Abramichev on 07/08/2019.
//

import MapKit
import Combine

protocol LocationService {
    var currentLocation: CLLocation { get }
    var didChange: PassthroughSubject<CLLocation,Never> { get }
}


class LocationServiceImplementation: NSObject, LocationService {
    private let defaultCoordinates = CLLocationCoordinate2D(latitude: 52.313388, longitude: 5.037687)
    private let manager = CLLocationManager()
    
    var didChange = PassthroughSubject<CLLocation, Never>()
   
    
    lazy var currentLocation: CLLocation = {
        manager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            manager.startUpdatingLocation()
        }
        
        return manager.location ?? CLLocation(latitude: defaultCoordinates.latitude,
                                              longitude: defaultCoordinates.longitude)
    }()

    
}

extension LocationServiceImplementation: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        didChange.send(location)
    }
}
