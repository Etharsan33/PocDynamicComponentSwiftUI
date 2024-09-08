//
//  View++.swift
//
//
//  Created by Elankumaran Tharsan on 03/04/2024.
//

import SwiftUI

public extension View {
    
    @available(iOS 15.0, *)
    func listItemWithoutSeparator() -> some View {
        self.listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
    }
    
    func rounded() -> some View {
        self.clipShape(Circle())
    }

    func color(_ value: Color) -> some View {
        if #available(iOS 15.0, *) {
            return self.foregroundStyle(value)
        } else {
            return self.foregroundColor(value)
        }
    }
    
    @ViewBuilder 
    func applyIf<T: View>(_ condition: @autoclosure () -> Bool, apply: (Self) -> T) -> some View {
        if condition() {
            apply(self)
        } else {
            self
        }
    }
    
    func apply<V: View>(@ViewBuilder _ block: (Self) -> V) -> V {
        block(self)
    }
}

