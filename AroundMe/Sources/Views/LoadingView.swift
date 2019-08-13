//
//  LoadingView.swift
//  AroundMeApp
//
//  Created by Vladimir Abramichev on 10/08/2019.
//

import SwiftUI

struct LoadingView: View {

    let title: String
    @ObservedObject var viewModel: InitViewModel

    var body: some View {
        GeometryReader { geometry in
                VStack {
                    Text(self.title)
                    ActivityIndicator(isAnimating: self.$viewModel.isLoading, style: .large)
                }
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.height / 5)
            }
        }
    }
