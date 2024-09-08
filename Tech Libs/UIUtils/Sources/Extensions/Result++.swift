//
//  Result++.swift
//
//
//  Created by Elankumaran Tharsan on 13/04/2024.
//

import Foundation

public extension Result {
    
    func onSuccess(_ completion: (Success) -> Void) -> Self {
        if let success = try? self.get() {
            completion(success)
        }
        return self
    }
}
