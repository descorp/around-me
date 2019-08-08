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

struct RootView : View {
    
    @ObservedObject var viewModel: RootViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            MapView()
            DropDownList(rowHeight: 72,
                         selectedItem: viewModel.categories[0],
                         items: $viewModel.categories)
                .padding(16)
                .clipShape(RoundedRectangle(cornerRadius: 36.0, style: .continuous))
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
