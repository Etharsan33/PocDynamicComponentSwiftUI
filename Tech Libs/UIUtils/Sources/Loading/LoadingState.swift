//
//  LoadingState.swift
//
//
//  Created by Elankumaran Tharsan on 26/12/2023.
//

import Foundation
import SwiftUI

public struct LoadingStateData {
    public enum CtaType {
        public typealias Action = () -> Void
        case retry(String, Action), custom(String, Action)
    }
    
    public let image: Image?
    public let title: String?
    public let message: String
    public let ctaType: CtaType?
    
    public init(image: Image? = nil, title: String? = nil, message: String, ctaType: CtaType? = nil) {
        self.image = image
        self.title = title
        self.message = message
        self.ctaType = ctaType
    }
}

public enum ViewLoadingState<Content> {
    case loading(placeholder: Content),
         loaded(content: Content),
         error(LoadingStateData)
}

public enum CollectionLoadingState<Content> {
    case loading(placeholder: Content),
         loaded(content: Content, prefetchable: Bool),
         empty(LoadingStateData),
         error(LoadingStateData),
         prefetchError(content: Content, LoadingStateData)
}
