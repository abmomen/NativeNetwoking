//
//  NetworkError.swift
//  URLSessionNetworking
//
//  Created by ST-iOS on 6/28/22.
//

import Foundation

public enum NetworkError<T: ErrorProtocol>: Error {
    case invalidJSON
    case invalidResponse
    case decodingError
    case defaultError(Error)
    case backendError(T)
    
    var description: String {
        switch self {
        case .invalidJSON:
            return "Invalid Json data"
        case .invalidResponse:
            return "Invalid Response"
        case .decodingError:
            return "Could not decode response"
        case .defaultError(let error):
            return error.localizedDescription
        case .backendError(let error):
            return error.message ?? "Unknown error occured"
        }
    }
}
