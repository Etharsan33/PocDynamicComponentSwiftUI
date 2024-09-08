//
//  FetchCarouselListSectionComponentUseCase.swift
//  
//
//  Created by Elankumaran Tharsan on 12/06/2024.
//

import Foundation
import SharedDomain

protocol FetchCarouselListSectionComponentUseCase {
    func execute(latitude: Double, longitude: Double, distance: Int, link: DynamicListLink) async -> Result<Void, DomainError>
}

struct DefaultFetchCarouselListSectionComponentUseCase: FetchCarouselListSectionComponentUseCase {
    let dynamicListRepository: DynamicListRepository
    
    func execute(latitude: Double, longitude: Double, distance: Int, link: DynamicListLink) async -> Result<Void, DomainError> {
        sleep(4)
        return await dynamicListRepository.fetchCarouselListSectionComponent(latitude: latitude, longitude: longitude, distance: distance, link: link)
    }
}
