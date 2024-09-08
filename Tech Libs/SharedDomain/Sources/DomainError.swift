//
//  DomainError.swift
//
//
//  Created by Elankumaran Tharsan on 29/12/2023.
//

import Foundation

public enum DomainError: Error {
    case error(code: Int, message: String)
    case unAuthorized
    case noNetwork
    case serverNotAvailable
    case unknown
}

extension DomainError: LocalizedError {
    
    public var errorDescription: String? { // TODO: - Lokalise
        switch self {
        case .unknown:
            return "An unknown error is happend"
        case .serverNotAvailable:
            return "Server not available"
        case .noNetwork:
            return "No network connexion"
        case .unAuthorized:
            return "Not authorized"
        case .error(_, let messsage):
            return messsage
        }
    }
}
