//
//  URLEncoding.swift
//  URLSessionNetworking
//
//  Created by ST-iOS on 6/28/22.
//

import Foundation

enum URLEncoding {
    static func encode(_ request: inout URLRequest, with params: Parameters?) {
        guard let url = request.url else {return}
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {return}
        guard let params = params else { return }
        urlComponents.queryItems?.removeAll()
        
        for (k, v) in params {
            let queryItem = URLQueryItem(name: k, value: "\(v)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
            urlComponents.queryItems?.append(queryItem)
        }
        request.url = urlComponents.url
    }
}
