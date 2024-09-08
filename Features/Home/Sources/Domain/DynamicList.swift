//
//  Home.swift
//
//
//  Created by Elankumaran Tharsan on 11/06/2024.
//

import Foundation

struct DynamicList {
    struct Body {
        let sections: [Section]
    }
    let body: Body
    
    struct Section {
        let id: String
        let title: String?
        let components: [SectionComponent]
    }

    struct SectionComponent: Identifiable {
        let id: String
        let type: String
        let links: [ComponentLink]
    }

    struct ComponentLink: DynamicListLink {
        let id: String
        let link: String
        let method: String
        let params: [String: Any]?
    }
}


