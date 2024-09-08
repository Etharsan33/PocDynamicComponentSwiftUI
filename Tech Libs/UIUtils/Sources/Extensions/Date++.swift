//
//  Date++.swift
//
//
//  Created by Elankumaran Tharsan on 10/05/2024.
//

import Foundation

public extension Date {
    
    /// ddMMyyyy Date formatter
    static let ddMMyyyySlashedFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    var ddMMyyyySlashed: String {
        return Date.ddMMyyyySlashedFormatter.string(from: self)
    }
    
    /// HH:mm Date formatter
    static let hhmmFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    var hhmm: String {
        return Date.hhmmFormatter.string(from: self)
    }
}
