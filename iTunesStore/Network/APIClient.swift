//
//  APIClient.swift
//  iTunesStore
//
//  Created by RemotoDojo on 8/21/21.
//

import Foundation
import Combine

// MARK: - Request Resource
class APIClient<Resource: APIResource> {
    let resource: Resource
    
    init(using resource: Resource) {
        self.resource = resource
    }
    
    enum APIError: Error, LocalizedError {
        case unknown, apiError(reason: String)
        
        var errorDescription: String? {
            switch self {
            case .unknown:
                return "Unknown Error"
            case .apiError(let reason):
                return reason
            }
        }
    }

    func run() -> AnyPublisher<Resource.ModelType, Error> {
        var urlRequest = URLRequest(url: resource.url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.timeoutInterval = 60
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { $0.data }
            .decode(type: Resource.ModelType.self, decoder: JSONDecoder())
            .mapError { error in
                if let error = error as? APIError {
                    return error
                } else {
                    return APIError.apiError(reason: error.localizedDescription)
                }
            }
            .eraseToAnyPublisher()
    }
}
