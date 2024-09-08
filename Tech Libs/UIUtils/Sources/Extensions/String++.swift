//
//  String++.swift
//
//
//  Created by Elankumaran Tharsan on 01/04/2024.
//

import Foundation
import SwiftUI

public extension String {
    
    @available(iOS 15, *)
    func toHTMLAttribute(font: Font) -> AttributedString? {
        let htmlString =
        """
        <style>
        a { color: black !important; }
        </style> \(self)
        """
        
        guard let data = htmlString.data(using: .unicode),
                let nsAttributedString = try? NSMutableAttributedString(data: data,
                                                               options: [.documentType: NSAttributedString.DocumentType.html],
                                                               documentAttributes: nil) else {
            return nil
        }
        
        if nsAttributedString.string.last == "\n" {
            nsAttributedString.deleteCharacters(in: NSRange(location: nsAttributedString.length - 1, length: 1))
        }
        
        var attr = try? AttributedString(nsAttributedString, including: \.uiKit)
        attr?.font = font
        return attr
    }
    
    static func random(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstu vwxyz"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    var isEmptyWithoutWhitespaces: Bool {
        return self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
