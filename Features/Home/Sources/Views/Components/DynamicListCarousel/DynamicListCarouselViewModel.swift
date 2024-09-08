//
//  DynamicListCarouselViewModel.swift
//
//
//  Created by Elankumaran Tharsan on 12/06/2024.
//

import SwiftUI
import UIUtils

final class DynamicListCarouselViewModel: ObservableObject {
    
    private let link: DynamicListLink
    private let fetchCarouselListSectionComponentUseCase: FetchCarouselListSectionComponentUseCase
    
    @Published var items: CollectionLoadingState<[AdItem]> = .loading(placeholder: [.init(id: UUID().uuidString, title: UUID().uuidString, picture: nil), .init(id: UUID().uuidString, title: UUID().uuidString, picture: nil)])
    
    init(link: DynamicListLink,
         fetchCarouselListSectionComponentUseCase: FetchCarouselListSectionComponentUseCase) {
        self.link = link
        self.fetchCarouselListSectionComponentUseCase = fetchCarouselListSectionComponentUseCase
    }
    
    @MainActor
    func viewDidLoad() async {
        let result = await fetchCarouselListSectionComponentUseCase.execute(latitude: 2.10, longitude: 4.20, distance: 10, link: self.link)
        
        switch result {
        case .success:
            items = .loaded(content: [
                .init(id: UUID().uuidString, title: "item 1", picture: nil),
                .init(id: UUID().uuidString, title: "item 2", picture: nil),
                .init(id: UUID().uuidString, title: "item 3", picture: nil),
                .init(id: UUID().uuidString, title: "item 4", picture: nil),
                .init(id: UUID().uuidString, title: "item 5", picture: nil),
                .init(id: UUID().uuidString, title: "item 6", picture: nil)
            ], prefetchable: false)
        case .failure(let error):
            items = .error(.init(message: error.localizedDescription))
        }
    }
}
