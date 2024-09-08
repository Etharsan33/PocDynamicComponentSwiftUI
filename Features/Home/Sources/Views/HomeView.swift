//
//  HomeView.swift
//
//
//  Created by Elankumaran Tharsan on 12/06/2024.
//

import SwiftUI
import UIUtils
import SharedDomain

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        CollectionLoadingView(loadingState: viewModel.sections) { items in
            List(items, id: \.id) { item in
                VStack {
                    if let title = item.title {
                        Text(title)
                    }
                    
                    ForEach(item.components) { component in
                        getComponent(component)
                    }
                }
                .listItemWithoutSeparator()
            }
        }
        .onViewDidLoad {
            Task {
                await viewModel.viewDidLoad()
            }
        }
    }
    
    @ViewBuilder
    private func getComponent(_ component: DynamicList.SectionComponent) -> some View {
        if component.type == "carrousel",
            let link = component.links.first {
            DynamicListCarouselView(viewModel: .init(link: link, fetchCarouselListSectionComponentUseCase: HomeInjector.fetchCarouselListSectionComponentUseCase))
        }
    }
}

#Preview {
    struct ListUseCase: FetchDynamicListUseCase {
        func execute(screenName: String) async -> Result<DynamicList, DomainError> {
            sleep(4)
            let sections: [DynamicList.Section] = [
                .init(id: UUID().uuidString,
                      title: "une section 1",
                      components: [
                        .init(id: UUID().uuidString, type: "carrousel", links: [
                            .init(id: UUID().uuidString,
                                  link: "", method: "", params: nil)
                        ])
                      ]),
                .init(id: UUID().uuidString,
                      title: "une section 2",
                      components: [
                        .init(id: UUID().uuidString, type: "carrousel", links: [
                            .init(id: UUID().uuidString,
                                  link: "", method: "", params: nil)
                        ])
                      ])
            ]
            return .success(.init(body: .init(sections: sections)))
        }
    }
//    return HomeView(viewModel: .init(fetchDynamicListUseCase: HomeInjector.fetchDynamicListUseCase))
        return HomeView(viewModel: .init(fetchDynamicListUseCase: ListUseCase()))
}
