//
//  DropDownList.swift
//  AroundMe
//
//  Created by Vladimir Abramichev on 07/08/2019.
//

import SwiftUI

protocol ListItem: class, Hashable, Identifiable {
    var name: String { get }
    var iconUrl: String? { get }
}

struct DropDownListItem<T>: View where T: ListItem {
    var item: T

    var body: some View {
        HStack(alignment: .center, spacing: 16.0) {
            URLImage(url: self.item.iconUrl, contentMode: .scaleAspectFit, tintColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1))
                .frame(width: 32, height:32)
            Text(item.name)
        }
    }
}

struct DropDownList<T>: View where T: ListItem {
    let rowHeight: CGFloat
    @State private var isColapsed = true
    @Binding var selectedItem: T
    @Binding var items: [T]
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            if isColapsed {
                Text(selectedItem.name)
                    .frame(height: 42)
                    .onTapGesture { self.isColapsed.toggle() }
            }
            
            if !isColapsed {
                HStack() {
                    List(items) { item in
                        Button(action: {
                            self.onSelected(item: item)
                        }) {
                            DropDownListItem(item: item)
                                .frame(height: self.rowHeight - 12.5)
                        }
                    }
                    .listRowInsets(EdgeInsets())
                    .frame(maxHeight: CGFloat(min(items.count, 4)) * rowHeight)
                }
                .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
            }
        }
        .frame(width: UIScreen.main.bounds.width - 32)
        .background(Color.white)
        .cornerRadius(16)
        .animation(.spring(), value: isColapsed)
    }
    
    func onSelected(item: T) {
        self.selectedItem = item
        self.isColapsed = true
    }
}
