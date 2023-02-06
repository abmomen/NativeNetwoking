//
//  NetworkError.swift
//  URLSessionNetworking
//
//  Created by ST-iOS on 6/28/22.
//

import Foundation

public enum NetworkError<T: ErrorProtocol>: Error {
    case invalidResponse
    case serverError(_ statusCode: Int)
    case decodingError
    case defaultError(Error)
    case customError(T)
    
    var description: String {
        switch self {
            
        case .invalidResponse:
            return "There is no data in the response."
            
        case .serverError(let code):
            return "Error from server with status code \(code)"
            
        case .decodingError:
            return "Could not decode response"
            
        case .defaultError(let error):
            return error.localizedDescription
            
        case .customError(let error):
            return error.message ?? "Unknown error occurred"
        }
    }
}
