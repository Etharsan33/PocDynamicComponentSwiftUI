//
//  AdItemView.swift
//
//
//  Created by Elankumaran Tharsan on 19/06/2024.
//

import SwiftUI
import UIUtils

struct AdItem: Identifiable {
    let id: String
    let title: String
    let picture: URL?
}

struct AdItemView: View {
    let item: AdItem
    
    var body: some View {
        VStack {
            CachedAsyncImage(url: item.picture, content: { image in
                image.resizable()
            }, placeholder: {
                Rectangle().color(.red)
            })
            .frame(height: 140)
            VStack {
                Text(item.title)
            }
            .padding(.all, .ds.l)
        }
    }
}

#Preview {
    AdItemView(item: .init(id: "", title: "test ad", picture: nil))
}
