//
//  AdCategoriesCache.swift
//
//
//  Created by Elankumaran Tharsan on 02/06/2024.
//

import Foundation

public protocol AdCategoriesCache {
    var categories: [AdCategory] { get }
    func getCategory(by id: String) -> AdCategory
    func getCategoryParent(by id: String) -> AdCategory
}

public struct DefaultAdCategoriesCache: AdCategoriesCache {
    public let categories: [AdCategory]
    
    public init(categories: [AdCategory]) {
        self.categories = categories
    }
    
    public func getCategory(by id: String) -> AdCategory {
        return self.categories
            .compactMap { category -> AdCategory? in
                if category.id == id {
                    return category
                }
                return category.children?.first(where: { $0.id == id })
            }.first ?? AdCategory.default
    }
    
    public func getCategoryParent(by id: String) -> AdCategory {
        return self.categories.first(where: { $0.children?.contains(where: { $0.id == id }) == true }) ?? AdCategory.default
    }
}
