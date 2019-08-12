//
//  MapView.swift
//  AroundMe
//
//  Created by Vladimir Abramichev on 07/08/2019.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    @Binding var currentLocation: CLLocation
    
    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        MKMapView()
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        uiView.isUserInteractionEnabled = false
        uiView.setRegion(MKCoordinateRegion(center: currentLocation.coordinate, span: span), animated: true)
        uiView.showsUserLocation = true
    }
}
