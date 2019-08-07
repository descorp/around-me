//
//  MapView.swift
//  AroundMe
//
//  Created by Vladimir Abramichev on 07/08/2019.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    let locationManager = LocationService()
    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        MKMapView()
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        uiView.isUserInteractionEnabled = false
        uiView.setRegion(MKCoordinateRegion(center: locationManager.coordinates, span: span), animated: true)
    }
}
