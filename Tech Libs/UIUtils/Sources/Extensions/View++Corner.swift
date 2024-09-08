//
//  View++Corner.swift
//
//
//  Created by Elankumaran Tharsan on 28/04/2024.
//

import SwiftUI

private struct ModifierCornerRadiusWithBorder: ViewModifier {
    let radius: CGFloat
    let borderLineWidth: CGFloat
    let borderColor: Color
    
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: self.radius)
                    .strokeBorder(self.borderColor, lineWidth: self.borderLineWidth)
            )
    }
}

private struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

public extension View {
    
    func cornerRadius(_ value: CGFloat) -> some View {
        clipShape(RoundedRectangle(cornerRadius: value))
    }
    
    func cornerRadiusWithBorder(radius: CGFloat, width: CGFloat = 1, color: Color) -> some View {
        modifier(ModifierCornerRadiusWithBorder(radius: radius, borderLineWidth: width, borderColor: color))
    }
    
    func cornerRadius(_ value: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: value, corners: corners))
    }
}
