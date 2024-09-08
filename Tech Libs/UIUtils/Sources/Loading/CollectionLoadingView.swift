//
//  CollectionLoadingView.swift
//
//
//  Created by Elankumaran Tharsan on 29/12/2023.
//

import SwiftUI

public struct CollectionLoadingView<Item, Content: View>: View {
    private let fade = AnyTransition.opacity.animation(Animation.linear(duration: 0.5))
    private let state: CollectionLoadingState<[Item]>
    private let makeContent: ([Item]) -> Content
    
    public init(
        loadingState: CollectionLoadingState<[Item]>,
        @ViewBuilder content: @escaping ([Item]) -> Content
    ) {
        state = loadingState
        makeContent = content
    }
    
    public var body: some View {
        switch state {
        case let .loading(placeholders):
            makeContent(placeholders)
                .redacted(reason: .placeholder)
                .disabled(true)
                .transition(fade)
        case let .loaded(items, prefetchable):
            makeContent(items)
                .transition(fade)
            if prefetchable {
                PrefetchStateView(state: .loading)
            }
        case let .empty(data):
            LoadingStateView(data: data)
                .transition(fade)
        case let .error(data):
            LoadingStateView(data: data)
                .transition(fade)
        case let .prefetchError(items, data):
            makeContent(items)
                .transition(fade)
            PrefetchStateView(state: .error(data))
        }
    }
}


