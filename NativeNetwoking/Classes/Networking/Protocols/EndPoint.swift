//
//  EndPoint.swift
//  URLSessionNetworking
//
//  Created by ST-iOS on 6/28/22.
//

import Foundation

protocol EndPoint {
    var baseUrl: String { get }
    var path: String { get }
    var body: Data? { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
    var authentication: String? { get }
}

extension EndPoint {
    var baseUrl: String {
        return Constants.baseUrl
    }
    
    var body: Data? {
        return nil
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String: String]? {
        return [:]
    }
    
    var parameters: [String: Any]? {
        return [:]
    }
    
    var authentication: String? {
        return nil
    }
    
    var request: URLRequest {
        let url = URL(string: "\(baseUrl)\(path)")!
        var request = URLRequest(url: url, timeoutInterval: 120)
        URLEncoding.encode(&request, with: parameters)
        request.httpBody = body
        request.httpMethod = method.rawValue
        addHeader(&request)
        return request
    }
    
    fileprivate func addHeader(_ request: inout URLRequest) {
        request.setValue(authentication, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
}
