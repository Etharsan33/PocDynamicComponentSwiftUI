//
//  LoadingButton.swift
//
//
//  Created by Elankumaran Tharsan on 12/05/2024.
//

import SwiftUI

public struct LoadingButton<T: View>: View {
    let isLoading: Bool
    let isEnable: Bool
    let action: () -> Void
    let view: () -> T
    
    public init(isLoading: Bool, isEnable: Bool, action: @escaping () -> Void, view: @escaping () -> T) {
        self.isLoading = isLoading
        self.isEnable = isEnable
        self.action = action
        self.view = view
    }
    
    public var body: some View {
        Button(action: action, label: {
            if isLoading {
                ProgressView()
            } else {
                view()
            }
        })
        .disabled(isLoading  || !isEnable)
        .opacity(isEnable ? 1 : 0.5)
    }
}
