//
//  DynamicListRemote.swift
//
//
//  Created by Elankumaran Tharsan on 12/06/2024.
//

import Foundation

struct DynamicListRemote: Decodable {
    struct Screen: Decodable {
        let structure: Structure
    }
    
    struct Structure: Decodable {
        let body: Body
    }
    
    struct Body: Decodable {
        let sections: [Section]
    }

    struct Section: Decodable {
        let id: String
        let title: String?
        let components: [SectionComponent]?
    }

    struct SectionComponent: Decodable {
        let id: String
        let type: String
        let _links: [ComponentLink]
    }

    struct ComponentLink: Decodable {
        let rel: String
        let href: String
        let method: String
//        let schema: String?
    }
    
    let screen: Screen
}

extension DynamicListRemote {
    
    func toDomain() -> DynamicList {
        return .init(body: .init(sections: self.screen.structure.body.sections.map { $0.toDomain() }))
    }
}

extension DynamicListRemote.Section {
    
    func toDomain() -> DynamicList.Section {
        return .init(id: self.id, title: self.title,
                     components: (self.components?.compactMap { $0.toDomain() }) ?? [])
    }
}

extension DynamicListRemote.SectionComponent {
    
    func toDomain() -> DynamicList.SectionComponent {
        func toLink(_ link: DynamicListRemote.ComponentLink) -> DynamicList.ComponentLink {
//            print(link.schema)
//            let params = link.schema.flatMap(convertToDictionary(text:))
//            print(params)
            return .init(id: link.rel,
                         link: link.href,
                         method: link.method,
                         params: nil)
        }
        
        return .init(id: self.id, type: self.type, links: self._links.map(toLink))
    }
    
    private func convertToDictionary(text: String) -> [String: Any]? {
        guard let data = text.data(using: .utf8) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    }
}
