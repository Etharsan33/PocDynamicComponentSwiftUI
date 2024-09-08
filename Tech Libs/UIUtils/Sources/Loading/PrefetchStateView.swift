//
//  PrefetchStateView.swift
//
//
//  Created by Elankumaran Tharsan on 29/12/2023.
//

import SwiftUI

struct PrefetchStateView: View {
    enum State {
        case loading, error(LoadingStateData)
    }
    var state: State
    
    var body: some View {
        switch state {
        case .loading:
            ProgressView() {
                Text("Loading ...")
            }.frame(height: 100)
        case .error(let data):
            LoadingStateView(data: data)
        }
    }
}

#Preview {
    PrefetchStateView(state: .loading)
}
