//
//  UrlImage.swift
//  AroundMeApp
//
//  Created by Vladimir Abramichev on 12/08/2019.
//

import SwiftUI
import Combine
import UIKit

struct URLImage: UIViewRepresentable {
    var url: String?
    let contentMode: UIView.ContentMode

    @Injected var imageLoader: ImageLoader
    
    func makeUIView(context: UIViewRepresentableContext<URLImage>) -> UIImageView {
        let view = UIImageView()
        view.contentMode = contentMode
        return view
    }
    
    func updateUIView(_ uiView: UIImageView, context: UIViewRepresentableContext<URLImage>) {
        guard let rawUrl = url, let url = URL(string: rawUrl), let data = try? Data(contentsOf: url) else { return }
        uiView.image = UIImage(data: data)?.withAlignmentRectInsets(UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }
    
}

protocol ImageLoader: class {
    
    
}
