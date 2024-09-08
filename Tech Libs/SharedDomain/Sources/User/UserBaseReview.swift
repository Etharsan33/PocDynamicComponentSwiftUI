//
//  UserBaseReview.swift
//
//
//  Created by Elankumaran Tharsan on 04/05/2024.
//

import Foundation

public protocol UserBaseReview {
    var reviewCount: Int { get }
    var reviewSum: Double { get }
}

public extension UserBaseReview {
    
    var reviewAverage: Double? {
        guard self.reviewCount > 0 else { return nil }
        let total = self.reviewSum / Double(self.reviewCount)
        
        guard total >= 1 else { return nil }
        if total >= 4.9 {
            return 5.0
        }
        return total
    }
    
}
