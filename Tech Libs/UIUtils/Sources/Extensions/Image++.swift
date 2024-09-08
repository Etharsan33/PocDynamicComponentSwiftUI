//
//  Image++.swift
//
//
//  Created by Elankumaran Tharsan on 03/05/2024.
//

import SwiftUI

public extension Image {
    
    @available(iOS 15.0, *)
    func tint(_ color: Color) -> some View {
        self.renderingMode(.template)
            .foregroundStyle(color)
    }
}
