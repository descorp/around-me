//
//  ContentView.swift
//  AroundMe
//
//  Created by Vladimir Abramichev on 03/08/2019.
//  Copyright © 2019 Vladimir Abramichev. All rights reserved.
//

import SwiftUI
import MapKit
import Combine

struct VenuesView: View {
    @ObservedObject var viewModel: VenuesViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            MapView(currentLocation: $viewModel.curentLocation,
                    venues: $viewModel.venues,
                    radius: $viewModel.radius)
                .edgesIgnoringSafeArea([.top, .bottom])
            DropDownList(rowHeight: 72,
                         selectedItem: $viewModel.selectedCategorie,
                         items: $viewModel.categories)
        }
    }
}


#if DEBUG
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
#endif
