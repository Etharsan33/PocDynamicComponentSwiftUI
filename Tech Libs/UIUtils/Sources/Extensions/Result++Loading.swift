//
//  Result++Loading.swift
//
//
//  Created by Elankumaran Tharsan on 30/12/2023.
//

import Foundation
import SwiftUI

public extension Result {
    
    func toLoadingState(errorData: LoadingStateData) -> ViewLoadingState<Success> {
        switch self {
        case .success(let success):
            return .loaded(content: success)
        case .failure:
            return .error(errorData)
        }
    }
    
    func toLoadingState(customErrorMessage: String? = nil, retryAction: @escaping () -> Void) -> ViewLoadingState<Success> {
        switch self {
        case .success(let success):
            return .loaded(content: success)
        case .failure(let failure): // - TODO: SEE WITH DESIGNER TO CONFORM TO DEFAULT TEXT & IMAGE
            return .error(.init(image: nil, title: nil, message: customErrorMessage ?? failure.localizedDescription, ctaType: .retry("Please retry", retryAction)))
        }
    }
}

public extension Result where Success: Collection {
    
    func toLoadingState(prefetchPreviousData: Success,
                        emptyData: LoadingStateData,
                        errorData: LoadingStateData,
                        prefetchable: Bool) -> CollectionLoadingState<Success> {
        switch self {
        case .success(let success):
            if prefetchPreviousData.isEmpty && success.isEmpty {
                return .empty(emptyData)
            }
            return .loaded(content: success, prefetchable: prefetchable)
        case .failure:
            if prefetchable && !prefetchPreviousData.isEmpty {
                return .prefetchError(content: prefetchPreviousData, errorData)
            }
            return .error(errorData)
        }
    }
    
    func toLoadingState(previousData: Success? = nil,
                        prefetchable: Bool = false,
                        customEmptyImage: Image? = nil,
                        customEmptyMessage: String,
                        customErrorMessage: String? = nil,
                        retryAction: @escaping () -> Void) -> CollectionLoadingState<Success> {
        let previousDataIsEmpty = previousData == nil || previousData?.isEmpty == true
        switch self {
        case .success(let success):
            if previousDataIsEmpty && success.isEmpty {
                return .empty(.init(image: customEmptyImage, title: nil, message: customEmptyMessage, ctaType: nil))
            }
            return .loaded(content: success, prefetchable: prefetchable)
        case .failure(let failure): // - TODO: SEE WITH DESIGNER TO CONFORM TO DEFAULT TEXT & IMAGE
            let errorData = LoadingStateData(image: nil, title: nil, message: customErrorMessage ?? failure.localizedDescription, ctaType: .retry("Please retry", retryAction))
            
            if prefetchable && !previousDataIsEmpty, let previousData {
                return .prefetchError(content: previousData, errorData)
            }
            return .error(errorData)
        }
    }
}
