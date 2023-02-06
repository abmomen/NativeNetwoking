//
//  EndPoint.swift
//  URLSessionNetworking
//
//  Created by ST-iOS on 6/28/22.
//

import Foundation

public protocol EndPoint {
    var baseUrl: String { get }
    var path: String { get }
    var body: Data? { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
    var authentication: String? { get }
}

extension EndPoint {
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
        var urlComponents = URLComponents(string: baseUrl + path)!
        
        var encodedBodyData: Data?
        
        if let parameters {
            if method == .get {
                if let items = paramsToQueryItems(parameters) {
                    urlComponents.queryItems = items
                }
            } else {
                encodedBodyData = try? JSONSerialization.data(withJSONObject: parameters)
            }
        } else {
            encodedBodyData = body
        }
        
        var request = URLRequest(url: urlComponents.url!, timeoutInterval: 120)
        request.httpBody = encodedBodyData
        request.httpMethod = method.rawValue
        request.setValue(authentication, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}

extension EndPoint {
    private func queryItems(_ key: String, _ value: Any?) -> [URLQueryItem] {
        var result = [] as [URLQueryItem]
        
        if let dictionary = value as? [String: AnyObject] {
            for (nestedKey, value) in dictionary {
                result += queryItems("\(key)[\(nestedKey)]", value)
            }
        } else if let array = value as? [AnyObject] {
            let arrKey = key
            for value in array {
                result += queryItems(arrKey, value)
            }
        } else if let value = value {
            result.append(URLQueryItem(name: key, value: "\(value)"))
        } else {
            result.append(URLQueryItem(name: key, value: nil))
        }
        
        return result
    }
    
    func paramsToQueryItems(_ params: [String: Any]?) -> [URLQueryItem]? {
        guard let params = params else { return nil }
        
        var result = [] as [URLQueryItem]
        
        for (key, value) in params {
            result += queryItems(key, value)
        }
        
        return result
    }
}
