//
//  DS+Button.swift
//  
//
//  Created by Elankumaran Tharsan on 09/05/2024.
//

import SwiftUI

public extension CGFloat {
    /// 40px
    static var dsButtonHeight: CGFloat { return 40 }
}

public extension ButtonStyle where Self == DSButtonStyle {
    static var dsPrimary: DSButtonStyle { DSButtonStyle(style: .primary, fullWidth: true) }
    static var dsSecondary: DSButtonStyle { DSButtonStyle(style: .secondary, fullWidth: true) }
}

public struct DSButtonStyle: ButtonStyle {
    
    enum DSButtonStyle {
        case primary, secondary
    }
    
    let style: DSButtonStyle
    let fullWidth: Bool
    
    public func makeBody(configuration: Configuration) -> some View {
        getButton(configuration.label)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.spring(), value: configuration.isPressed)
    }
    
    @ViewBuilder
    private func getButton(_ button: ButtonStyleConfiguration.Label) -> some View {
        switch style {
        case .primary:
            primaryStyle(button)
        case .secondary:
            secondaryStyle(button)
        }
    }
    
    private func primaryStyle(_ button: ButtonStyleConfiguration.Label) -> some View {
        button.color(.ds.textPrimary)
            .font(.ds.button(.semibold))
            .padding([.trailing, .leading], .ds.m)
            .padding([.top, .bottom], .ds.l)
            .applyIf(fullWidth, apply: {
                $0.frame(minWidth: 0, maxWidth: .infinity)
            })
            .background(Color.ds.primary)
            .dsDefaultCornerRadius()
    }
    
    private func secondaryStyle(_ button: ButtonStyleConfiguration.Label) -> some View {
        button.color(.ds.textPrimary)
            .font(.ds.smallBody(.semibold))
            .padding([.trailing, .leading], .ds.m)
            .padding([.top, .bottom], .ds.l)
            .applyIf(fullWidth, apply: {
                $0.frame(minWidth: 0, maxWidth: .infinity)
            })
            .background(Color.clear)
            .cornerRadiusWithBorder(radius: .ds.m, color: .ds.primary)
    }
}
