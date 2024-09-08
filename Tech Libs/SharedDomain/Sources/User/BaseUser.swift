//
//  BaseUser.swift
//
//
//  Created by Elankumaran Tharsan on 03/05/2024.
//

import Foundation

public protocol BaseUser {
    var id: String { get }
    var firstName: String { get }
    var lastName: String? { get }
}

public extension BaseUser {
    
    var fullName: String {
        func getText() -> String {
            let lastName = self.lastName?.trimmingCharacters(in: .whitespacesAndNewlines)
            guard let firstLastNameChar = lastName?.first,
                  lastName?.isEmpty == false else {
                return self.firstName
            }
            return "\(firstName) \(String(firstLastNameChar))."
        }
        return getText().trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
