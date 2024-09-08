//
//  Task.swift
//
//
//  Created by Elankumaran Tharsan on 29/12/2023.
//

import Foundation
import SwiftUI

/// Source Search : https://stackoverflow.com/questions/72169600/swift-task-before-ios-15
/// Source Code : https://gist.github.com/alexito4/4a9a7c6e3dc447a4f762cf1cf7346b5e

public extension View {
    @available(iOS, obsoleted: 15.0, message: "SwiftUI.View.task is available on iOS 15.")
    @_disfavoredOverload
    @inlinable func task(
        priority: _Concurrency.TaskPriority = .userInitiated,
        @_inheritActorContext _ action: @escaping @Sendable () async -> Swift.Void
    ) -> some SwiftUI.View {
        modifier(MyTaskModifier(priority: priority, action: action))
    }
}

public struct MyTaskModifier: ViewModifier {
    private var priority: TaskPriority
    private var action: @Sendable () async -> Void
    public init(
        priority: TaskPriority,
        action: @escaping @Sendable () async -> Void
    ) {
        self.priority = priority
        self.action = action
        self.task = nil
    }

    @State private var task: Task<Void, Never>?

    public func body(content: Content) -> some View {
        if #available(iOS 15.0, *),
           #available(macCatalyst 15.0, *) {
            content
                .task(priority: priority, action)
        } else {
            content
                .onAppear {
                    self.task = Task {
                        await action()
                    }
                }
                .onDisappear {
                    self.task?.cancel()
                }
        }
    }
}
