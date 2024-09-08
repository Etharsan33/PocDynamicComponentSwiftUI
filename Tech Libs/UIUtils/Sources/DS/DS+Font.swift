//
//  DS+Font.swift
//
//
//  Created by Elankumaran Tharsan on 01/04/2024.
//

import UIKit
import CoreGraphics
import CoreText
import SwiftUI

public extension Font {
    struct ds {}
}

public extension Font.ds {
    
    // MARK: - Primary
    /// regular, 16pt font
    static func body(_ weight: PrimaryWeight = .regular) -> Font {
        return getFont(weight.fontName, size: 16, accessibilityFont: .body)
    }
    
    /// regular, 14pt font
    static func smallBody(_ weight: PrimaryWeight = .regular) -> Font {
        return getFont(weight.fontName, size: 14, accessibilityFont: .subheadline)
    }
    
    /// regular, 12pt font
    static func extraSmallBody(_ weight: PrimaryWeight = .regular) -> Font {
        return getFont(weight.fontName, size: 12, accessibilityFont: .caption)
    }
    
    /// regular, 24pt font
    static func title(_ weight: PrimaryWeight = .regular) -> Font {
        return getFont(weight.fontName, size: 24, accessibilityFont: .title)
    }
    
    /// regular, 20pt font
    static func subTitle(_ weight: PrimaryWeight = .regular) -> Font {
        return getFont(weight.fontName, size: 20, accessibilityFont: .title2)
    }
    
    /// regular, 16pt font
    static func button(_ weight: PrimaryWeight = .regular) -> Font {
        return getFont(weight.fontName, size: 16, accessibilityFont: .body)
    }
    
    /// regular, 10pt font
    static func counter(_ weight: PrimaryWeight = .regular) -> Font {
        return getFont(weight.fontName, size: 10, accessibilityFont: .caption2)
    }
    
    // MARK: - Arima
    static func arima(_ weight: ArimaWeight, size: CGFloat) -> Font {
        return getFont(weight.fontName, size: size, accessibilityFont: .body)
    }
    
    // MARK: - Consolas
    static func consolasRegular(size: CGFloat) -> Font {
        return getFont(ConsolasWeight.regular.fontName, size: size, accessibilityFont: .body)
    }
}

// MARK: - Get Font
extension Font.ds {
    
    private static func getFont(_ fontName: String,
                                size: CGFloat,
                                accessibilityFont: Font.TextStyle) -> Font {
        return .custom(fontName, size: size, relativeTo: accessibilityFont)
    }
}

// MARK: - Font Register list
/// Doing this for lazy load font
extension Font.ds {
    
    public struct PrimaryWeight {
        let fontName: String
        
        private init(fontName: String) {
            self.fontName = fontName
            Font.ds.register(name: fontName)
        }
        
        public static let regular = PrimaryWeight(fontName: "OpenSans-regular")
        public static let light = PrimaryWeight(fontName: "OpenSans-light")
        public static let semibold = PrimaryWeight(fontName: "OpenSans-semibold")
        public static let bold = PrimaryWeight(fontName: "OpenSans-bold")
    }
    
    public struct ArimaWeight {
        let fontName: String
        
        private init(fontName: String) {
            self.fontName = fontName
            Font.ds.register(name: fontName)
        }
        
        public static let light = ArimaWeight(fontName: "ArimaMadurai-light")
        public static let bold = ArimaWeight(fontName: "ArimaMadurai-bold")
        public static let black = ArimaWeight(fontName: "ArimaMadurai-black")
    }
    
    private struct ConsolasWeight {
        let fontName: String
        
        private init(fontName: String) {
            self.fontName = fontName
            Font.ds.register(name: fontName)
        }
        
        fileprivate static let regular = ConsolasWeight(fontName: "Consolas-regular")
    }
}

// MARK: - Register Font
/// Need to do this register font because is not auto-register using plist on a Package
/// https://www.bontouch.com/case/custom-fonts-in-a-swift-package/
extension Font.ds {
    
    private static func register(name: String) {
        do {
            try registerFont(named: name)
        } catch {
            let reason = error.localizedDescription
            fatalError("Failed to register font: \(reason)")
        }
    }
    
    private enum FontError: Error {
       case failedToRegisterFont
    }

    private static func registerFont(named name: String) throws {
        guard let asset = NSDataAsset(name: "Fonts/\(name)", bundle: Bundle.module),
              let provider = CGDataProvider(data: asset.data as NSData),
              let font = CGFont(provider),
              CTFontManagerRegisterGraphicsFont(font, nil) else {
            throw FontError.failedToRegisterFont
        }
    }
}

