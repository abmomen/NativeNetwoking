//
//  ErrorResponseModel.swift
//  URLSessionNetworking
//
//  Created by ST-iOS on 6/28/22.
//

import Foundation

public struct ErrorResponseModel: ErrorProtocol {
    
}

public protocol ErrorProtocol: Decodable {
    var code: Int? { get }
    var message: String? { get }
}

extension ErrorProtocol {
    public var code: Int? {
        return nil
    }
    
    public var message: String? {
        return nil
    }
}
