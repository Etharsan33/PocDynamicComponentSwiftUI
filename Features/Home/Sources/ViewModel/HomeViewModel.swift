//
//  HomeViewModel.swift
//
//
//  Created by Elankumaran Tharsan on 12/06/2024.
//

import SwiftUI
import UIUtils

final class HomeViewModel: ObservableObject {
    
    private let fetchDynamicListUseCase: FetchDynamicListUseCase
    
    @Published var sections: CollectionLoadingState<[DynamicList.Section]> = .loading(placeholder: [.init(id: UUID().uuidString, title: UUID().uuidString, components: []), .init(id: UUID().uuidString, title: UUID().uuidString, components: [])])
    
    init(fetchDynamicListUseCase: FetchDynamicListUseCase) {
        self.fetchDynamicListUseCase = fetchDynamicListUseCase
    }
    
    @MainActor
    func viewDidLoad() async {
        let result = await fetchDynamicListUseCase.execute(screenName: "home")
        
        switch result {
        case .success(let dynamicList):
            sections = .loaded(content: dynamicList.body.sections, prefetchable: false)
        case .failure(let error):
            print(error)
            sections = .error(.init(message: error.localizedDescription))
        }
    }
}
