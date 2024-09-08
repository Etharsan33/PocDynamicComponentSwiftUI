//
//  HomeInjector.swift
//
//
//  Created by Elankumaran Tharsan on 12/06/2024.
//

import Foundation
import HTTPClient
import SharedDomain

struct AppInjector {
    static let shared = AppInjector()
    
    var httpClient: HTTPClient {
        return HTTPInjector.httpClient(baseUrl: "https://any-link.fr")
    }
}

struct HomeInjector {
    
    static var fetchDynamicListUseCase: FetchDynamicListUseCase {
        return DefaultFetchDynamicListUseCase(dynamicListRepository: repository)
    }
    
    static var fetchCarouselListSectionComponentUseCase: FetchCarouselListSectionComponentUseCase {
        return DefaultFetchCarouselListSectionComponentUseCase(dynamicListRepository: repository)
    }
    
    private static var repository: DynamicListRepository {
        return DefaultDynamicListRepository(httpClient: AppInjector.shared.httpClient)
    }
}
