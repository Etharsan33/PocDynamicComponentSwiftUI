//
//  DS+Color.swift
//
//
//  Created by Elankumaran Tharsan on 01/04/2024.
//

import SwiftUI

public extension Color {
    struct ds {}
}

public extension Color.ds {
    
    static let primary = Color(hex: 0xffc639)
    static let primaryLight = Color(hex: 0xfff7e2)
    static let titlePrimary = Color.black
    static let textPrimary = Color(hex: 0x283237)
    static let grayLight = Color(hex: 0xe6e6e6)
    static let gray = Color(hex: 0x8b8989)
    static let gray50 = Color(hex: 0x909597)
    static let gray02 = Color(hex: 0xF3F3F3)
    static let gray20 = Color(hex: 0xCED0D1)
    static let error = Color(hex: 0xe12424)
    static let success = Color(hex: 0x65c33e)
    static let investor = Color(hex: 0x000B52)
}

private extension Color {
    init(hex: Int, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: opacity
        )
    }
}
