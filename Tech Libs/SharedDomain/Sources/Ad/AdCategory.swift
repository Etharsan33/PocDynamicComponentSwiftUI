//
//  AdCategory.swift
//
//
//  Created by Elankumaran Tharsan on 02/06/2024.
//

import Foundation

public struct AdCategory {
    public let id: String
    public let imageURL: String?
    public let labels: [String: String]
    public let active: Bool
    public let children: [AdCategory]?
}

extension AdCategory {
    
    private static let food = "food"
    private static let miscellaneous = "miscellaneous"
    
    public static let `default` = AdCategory(id: AdCategory.miscellaneous, imageURL: nil, labels: [
            "en": "Miscellaneous",
            "fr": "Divers"
        ], active: true, children: nil)
    
    public var isFood: Bool {
        return id == AdCategory.food
    }
    
    public var displayName: String {
        let language = Locale.current.languageCode?.lowercased() ?? "en"
        guard let label = labels[language] else {
            return labels["fr"] ?? ""
        }
        return label
    }
}
