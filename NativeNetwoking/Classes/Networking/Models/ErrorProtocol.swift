//
//  ErrorProtocol.swift
//  URLSessionNetworking
//
//  Created by ST-iOS on 6/28/22.
//

import Foundation

public protocol ErrorProtocol: Decodable, Error {
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

public struct CustomErrorModel: ErrorProtocol {
    
}
