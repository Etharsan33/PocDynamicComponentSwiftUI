//
//  MyNavigationView.swift
//
//
//  Created by Elankumaran Tharsan on 11/05/2024.
//

import SwiftUI

// INFO: for handle color -> https://github.com/haifengkao/SwiftUI-Navigation-Bar-Color
public struct MyNavigationView<Content>: View where Content: View {
    @ViewBuilder var content: () -> Content
    
    public init(content: @escaping () -> Content) {
        self.content = content
    }
    
    public var body: some View {
        if #available(iOS 16, *) {
            NavigationStack(root: content)
        } else {
            NavigationView(content: content)
        }
    }
}
