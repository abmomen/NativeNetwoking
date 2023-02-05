//
//  NetworkError.swift
//  URLSessionNetworking
//
//  Created by ST-iOS on 6/28/22.
//

import Foundation

enum NetworkError: Error {
    case invalidJSON
    case invalidResponse
    case decodingError
    case genericError(Error)
    case backendError(ErrorResponseModel)
    
    var description: String {
        switch self {
        case .invalidJSON:
            return "Invalid Json data"
        case .invalidResponse:
            return "Invalid Response"
        case .decodingError:
            return "Could not decode response"
        case .genericError(let error):
            return error.localizedDescription
        case .backendError(let error):
            return error.message ?? "Unknown error occured"
        }
    }
}
