//
//  GenericAPIClient.swift
//  URLSessionNetworking
//
//  Created by ST-iOS on 6/28/22.
//

import Foundation

public typealias ErrorModel = NetworkError<CustomErrorModel>

public protocol GenericAPIClient {
    static func startRequest<T: Decodable>(with endPoint: EndPoint,
                                           decoder: JSONDecoder,
                                           completion: @escaping (Result<T, ErrorModel>) -> Void)
}

public extension GenericAPIClient {
    static func startRequest<T: Decodable>(with endPoint: EndPoint,
                                           decoder: JSONDecoder = JSONDecoder(),
                                           completion: @escaping (Result<T, ErrorModel>) -> Void) {
        
        URLSession.shared.dataTask(with: endPoint.request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(.defaultError(error)))
                }
                return
            }
            
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                DispatchQueue.main.async {
                    completion(.failure(.serverError(response.statusCode)))
                }
                return
            }
            
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidResponse))
                }
                
                return
            }
            
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
                
            } catch {
                if let errorData = try? decoder.decode(CustomErrorModel.self, from: data) {
                    DispatchQueue.main.async {
                        completion(.failure(.customError(errorData)))
                    }
                    
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(.decodingError))
                    }
                }
            }
        }
        .resume()
    }
}
