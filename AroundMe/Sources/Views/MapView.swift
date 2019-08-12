//
//  MapView.swift
//  AroundMe
//
//  Created by Vladimir Abramichev on 07/08/2019.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    private let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    
    @Binding var currentLocation: CLLocation
    @Binding var venues: [MKAnnotation]
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let map = MKMapView()
        map.isUserInteractionEnabled = false
        map.showsUserLocation = true
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        uiView.setRegion(MKCoordinateRegion(center: currentLocation.coordinate, span: span), animated: true)
        uiView.addAnnotations(venues)
    }
}
