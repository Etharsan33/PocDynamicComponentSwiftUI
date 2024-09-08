//
//  DynamicListCarouselView.swift
//
//
//  Created by Elankumaran Tharsan on 12/06/2024.
//

import SwiftUI
import UIUtils
import SharedDomain

struct DynamicListCarouselView: View {
    @ObservedObject var viewModel: DynamicListCarouselViewModel
    
    var body: some View {
        CollectionLoadingView(loadingState: viewModel.items) { items in
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(items) { item in
                        AdItemView(item: item)
                    }
                    .padding(.leading, .ds.l)
                }
            }
        }
        .onViewDidLoad {
            Task {
                await viewModel.viewDidLoad()
            }
        }
    }
}

#Preview {
    
    struct DefaultUseCase: FetchCarouselListSectionComponentUseCase {
        func execute(latitude: Double, longitude: Double, distance: Int, link: any DynamicListLink) async -> Result<Void, DomainError> {
            return .failure(.noNetwork)
        }
    }
    struct CustomLink: DynamicListLink {
        let link: String = "https://search/items"
        let method: String = "POST"
        
        let params: [String : Any]? = [
            "mode":"carrousel",
            "placement":"home",
            "type":"exclusivities",
            "pagination": [
                "limit":10,
                "minResultLength":3,
                "skip":4
            ],
            "filters": [
                "type":"donation",
                "longitude":"{{longitude}}",
                "latitude":"{{latitude}}",
                "distance":"{{distance}}"
            ]
        ]
    }
//    return DynamicListCarouselView(viewModel: .init(link: CustomLink(), fetchCarouselListSectionComponentUseCase: HomeInjector.fetchCarouselListSectionComponentUseCase))
    
        return DynamicListCarouselView(viewModel: .init(link: CustomLink(), fetchCarouselListSectionComponentUseCase: DefaultUseCase()))
}
