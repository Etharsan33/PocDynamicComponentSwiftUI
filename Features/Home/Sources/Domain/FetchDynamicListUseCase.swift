//
//  FetchDynamicListUseCase.swift
//
//
//  Created by Elankumaran Tharsan on 11/06/2024.
//

import SharedDomain

protocol FetchDynamicListUseCase {
    func execute(screenName: String) async -> Result<DynamicList, DomainError>
}

struct DefaultFetchDynamicListUseCase: FetchDynamicListUseCase {
    let dynamicListRepository: DynamicListRepository
    
    func execute(screenName: String) async -> Result<DynamicList, DomainError> {
        return await dynamicListRepository.fetchDynamicList(screenName: screenName)
    }
}
