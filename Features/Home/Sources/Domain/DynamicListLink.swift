//
//  DynamicListLink.swift
//
//
//  Created by Elankumaran Tharsan on 12/06/2024.
//

import Foundation

protocol DynamicListLink {
    var link: String { get }
    var method: String { get }
    var params: [String: Any]? { get }
}
