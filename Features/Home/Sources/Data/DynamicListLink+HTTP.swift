//
//  DynamicListRepository.swift
//  
//
//  Created by Elankumaran Tharsan on 12/06/2024.
//

import Foundation
import HTTPClient

fileprivate struct DynamicListLinkPathType: HTTPPathType {
    var url: String?
    var path: String = ""
    var method: HTTPUrlMethod
    var bodyParameters: [String : Any]?
    var urlParameters: [String : Any]?
}

extension DynamicListLink {
    
    func toHttpPathType(params: [String: Any]?) -> HTTPPathType {
        let urlMethod: HTTPUrlMethod = HTTPUrlMethod(rawValue: self.method.lowercased()) ?? .get
        return DynamicListLinkPathType(url: self.link,
                                       method: urlMethod,
                                       bodyParameters: urlMethod != .get ? params : nil,
                                       urlParameters: urlMethod == .get ? params : nil)
    }
    
    func decodableDicoVariable(with values: [String: Any]) -> [String: Any]? {
        guard let params else { return nil }
        return self.decodableDicoVariable(in: params, with: values)
    }
    
    private func decodableDicoVariable(in dictionary: [String: Any], with values: [String: Any]) -> [String: Any] {
        var result = dictionary
        
        for (key, value) in dictionary {
            if let stringValue = value as? String,
               let regex = try? NSRegularExpression(pattern: "\\{\\{(.*?)\\}\\}", options: []) {
                let matches = regex.matches(in: stringValue, options: [], range: NSRange(location: 0, length: stringValue.count))
                
                var newValue = stringValue
                for match in matches.reversed() {
                    if let range = Range(match.range, in: stringValue) {
                        let placeholder = String(stringValue[range])
                        let keyName = String(placeholder.dropFirst(2).dropLast(2))
                        
                        if let replacementValue = values[keyName] {
                            newValue = newValue.replacingOccurrences(of: placeholder, with: "\(replacementValue)")
                        }
                    }
                }
                
                result[key] = newValue
            } else if let nestedDictionary = value as? [String: Any] {
                result[key] = decodableDicoVariable(in: nestedDictionary, with: values)
            }
        }
        
        return result
    }
}
