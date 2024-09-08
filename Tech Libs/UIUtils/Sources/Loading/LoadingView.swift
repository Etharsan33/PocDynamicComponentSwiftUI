//
//  LoadingView.swift
//
//
//  Created by Elankumaran Tharsan on 26/12/2023.
//

import SwiftUI

public struct LoadingView<Data, Content: View, ErrorContent: View>: View {
    private let fade = AnyTransition.opacity.animation(Animation.linear(duration: 0.5))
    private let state: ViewLoadingState<Data>
    private let makeContent: (Data) -> Content
    private let makeErrorContent: ((LoadingStateData) -> ErrorContent)?
    
    public init(loadingState: ViewLoadingState<Data>,
                @ViewBuilder _ content: @escaping (Data) -> Content) {
        state = loadingState
        makeContent = content
        makeErrorContent = nil
    }
    
    public init(loadingState: ViewLoadingState<Data>,
                @ViewBuilder content: @escaping (Data) -> Content,
                @ViewBuilder onError: @escaping (LoadingStateData) -> ErrorContent) {
        state = loadingState
        makeContent = content
        makeErrorContent = .some(onError)
    }
    
    public var body: some View {
        switch state {
        case let .loading(placeholder):
            makeContent(placeholder)
                .redacted(reason: .placeholder)
                .disabled(true)
                .transition(fade)
        case let .loaded(item):
            makeContent(item)
                .transition(fade)
        case let .error(data):
            if let makeErrorContent {
                makeErrorContent(data)
                    .transition(fade)
            } else {
                LoadingStateView(data: data)
                    .transition(fade)
            }
        }
    }
}


