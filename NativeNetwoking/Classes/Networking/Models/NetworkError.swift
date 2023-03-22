//
//  NetworkError.swift
//  URLSessionNetworking
//
//  Created by ST-iOS on 6/28/22.
//

import Foundation

public enum NetworkError<T: ErrorProtocol>: Error {
    case emptyDataRespone
    case serverError(_ statusCode: Int)
    case decodingError(Error)
    case defaultError(Error)
    case customError(T)
    
    public var description: String {
        switch self {
            
        case .emptyDataRespone:
            return "Response does not have any data"
            
        case .serverError(let code):
            return "Unsuccessful Status Code \(code)"
            
        case .decodingError(let error):
            return "Decoding Failed Error: \(error)"
            
        case .defaultError(let error):
            return error.localizedDescription
            
        case .customError(let error):
            return error.message ?? "Unknown Error"
        }
    }
}
