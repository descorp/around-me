//
//  MapView.swift
//  AroundMe
//
//  Created by Vladimir Abramichev on 07/08/2019.
//

import SwiftUI
import MapKit

protocol MapPin: Hashable, MKAnnotation { }

struct MapView<T: MapPin>: UIViewRepresentable {
    private let initialSpan = MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
    
    @Binding var currentLocation: CLLocation
    @Binding var venues: [T]
    @Binding var radius: Double
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let map = MKMapView()
        map.setRegion(MKCoordinateRegion(center: currentLocation.coordinate, span: initialSpan), animated: true)
        map.isRotateEnabled = false
        map.isScrollEnabled = false
        map.showsUserLocation = true
        map.setUserTrackingMode(.follow, animated: true)
        map.delegate = context.coordinator
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        uiView.setUserTrackingMode(.follow, animated: true)
        
        let needCleaning = context.coordinator.oldVenues.intersection(venues).count == 0
        if needCleaning {
            #if DEBUG
            print("Old: \(context.coordinator.oldVenues) \nNew: \(venues)")
            #endif
            context.coordinator.oldVenues.removeAll()
            uiView.removeAnnotations(uiView.annotations)
        }
        
        venues.forEach { _ = context.coordinator.oldVenues.insert($0) }
        uiView.addAnnotations(venues)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        private let parent: MapView
        private let throttler = Throttler(miliseconds: 1)
        var oldVenues = Set<AnyHashable>()
        
        init(parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, didChange mode: MKUserTrackingMode, animated: Bool) {
            throttler.throttle {
                DispatchQueue.main.async {
                    self.parent.radius = mapView.currentRadius()
                }
            }
        }
    }
}

extension MKMapView {

    func topCenterCoordinate() -> CLLocationCoordinate2D {
        return self.convert(CGPoint(x: self.frame.size.width / 2.0, y: 0), toCoordinateFrom: self)
    }

    func currentRadius() -> Double {
        let centerLocation = CLLocation(latitude: self.centerCoordinate.latitude, longitude: self.centerCoordinate.longitude)
        let topCenterCoordinate = self.topCenterCoordinate()
        let topCenterLocation = CLLocation(latitude: topCenterCoordinate.latitude, longitude: topCenterCoordinate.longitude)
        return centerLocation.distance(from: topCenterLocation)
    }

}
