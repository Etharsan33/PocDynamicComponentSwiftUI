//
//  DS+Spacing.swift
//
//
//  Created by Elankumaran Tharsan on 01/04/2024.
//

import Foundation
import SwiftUI

public extension CGFloat {
    struct ds {}
}

public extension CGFloat.ds {
    
    /// 4px
    static var s: CGFloat { return 4 }
    
    /// 8px
    static var m: CGFloat { return 8 }
    
    /// 16px
    static var l: CGFloat { return 16 }
    
    /// 24px
    static var xl: CGFloat { return 24 }
}

// MARK - Corner Radius
public extension View {
    
    /// radius: 8
    func dsDefaultCornerRadius() -> some View {
        self.cornerRadius(8)
    }
}
