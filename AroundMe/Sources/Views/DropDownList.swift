//
//  DropDownList.swift
//  AroundMe
//
//  Created by Vladimir Abramichev on 07/08/2019.
//

import SwiftUI

protocol ListItem: class, Hashable, Identifiable {
    var value: String { get }
}

struct DropDownListItem<T>: View where T:ListItem {
    var item: T
    
    init(item: T) {
        self.item = item
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 16.0) {
            Text(item.value)
        }
    }
}

struct DropDownList<T>: View where T: ListItem {
    let rowHeight: CGFloat
    @State var isColapsed = true
    @State var selectedItem: T
    @Binding var items: [T]
    
    var body: some View {
        VStack(alignment: .center) {
            DropDownListItem(item: self.selectedItem)
                
                .frame(height: self.rowHeight - 12.5)
                .onTapGesture { self.isColapsed.toggle() }
            if !isColapsed {
                List(items) { item in
                    Button(action: {
                        self.onSelected(item: item)
                        self.isColapsed = false
                    }) {
                        DropDownListItem(item: item)
                            .frame(height: self.rowHeight - 12.5)
                    }
                }
                .listRowInsets(EdgeInsets())
                .frame(maxHeight: CGFloat(min(items.count, 4)) * rowHeight)
            }
        }
    }
    
    func onSelected(item: T) {
        self.selectedItem = item
        self.isColapsed = true
    }
}
