//
//  DynamicListRepository.swift
//
//
//  Created by Elankumaran Tharsan on 12/06/2024.
//

import Foundation
import HTTPClient
import SharedDomain

protocol DynamicListRepository {
    func fetchDynamicList(screenName: String) async -> Result<DynamicList, DomainError>
    func fetchCarouselListSectionComponent(latitude: Double, longitude: Double, distance: Int, link: DynamicListLink) async -> Result<Void, DomainError>
}

struct DefaultDynamicListRepository: DynamicListRepository {
    let httpClient: HTTPClient
    
    func fetchDynamicList(screenName: String) async -> Result<DynamicList, DomainError> {
        await httpClient.request(DynamicListRemote.self, pathType: HomePathType.dynamicList(screenName))
            .map { $0.toDomain() }
            .mapError { $0.toDomain() }
    }
    
    func fetchCarouselListSectionComponent(latitude: Double, longitude: Double, distance: Int, link: DynamicListLink) async -> Result<Void, DomainError> {
        let params = link.decodableDicoVariable(with: [
            "longitude": longitude,
            "latitude": latitude,
            "distance": distance
        ])
        return await httpClient.requestWithEmptyResponse(pathType: link.toHttpPathType(params: params))
            .mapError { $0.toDomain() }
    }
}

extension HTTPError {
    
    func toDomain() -> DomainError {
        switch self {
        case .error(let code, let message):
            return .error(code: code, message: message)
        case .unAuthorized:
            return .unAuthorized
        case .noNetwork:
            return .noNetwork
        case .serverNotAvailable:
            return .serverNotAvailable
        case .mappingError, .unknown, .customResponse:
            return .unknown
        }
    }
}

enum HomePathType: HTTPPathType {
    case dynamicList(String)
    
    var path: String {
        switch self {
        case .dynamicList(let string):
            return "/v3/screens/\(string)"
        }
    }
    
    var method: HTTPUrlMethod {
        return .get
    }
    
    var bodyParameters: [String : Any]? {
        return nil
    }
    
    var urlParameters: [String : Any]? {
        return nil
    }
}
