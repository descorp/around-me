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

let categories = [
    Category(name: "Food"),
    Category(name: "Grocery"),
    Category(name: "Bus Stop"),
    Category(name: "Metro"),
    Category(name: "Food2"),
    Category(name: "Grocery2"),
    Category(name: "Bus Stop3"),
    Category(name: "Metro2")
]

struct ContentView : View {
    var body: some View {
        ZStack(alignment: .top) {
            MapView()
            DropDownList(rowHeight: 72, selectedItem: categories[0], items: categories)
                .padding(16)
                .clipShape(RoundedRectangle(cornerRadius: 36.0, style: .continuous))
        }
    }
}


#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
