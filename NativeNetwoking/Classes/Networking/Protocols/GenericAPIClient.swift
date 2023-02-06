//
//  GenericAPIClient.swift
//  URLSessionNetworking
//
//  Created by ST-iOS on 6/28/22.
//

import Foundation

public protocol GenericAPIClient {
    func startRequest<T: Decodable, E: ErrorProtocol>(with endPoint: EndPoint,
                                           decoder: JSONDecoder,
                                           completion: @escaping (Result<T, NetworkError<E>>) -> Void)
}

extension GenericAPIClient {
    func startRequest<T: Decodable>(with endPoint: EndPoint,
                                           decoder: JSONDecoder = JSONDecoder(),
                                           completion: @escaping (Result<T, NetworkError<ErrorResponseModel>>) -> Void) {
        let session = URLSession.shared
        session.dataTask(with: endPoint.request) { data, response, error in
            if let error = error {
                completion(.failure(.defaultError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(.failure(.invalidResponse))
                return
            }
            
            
            guard let data = data else {
                completion(.failure(.invalidJSON))
                return
            }
            
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
                
            } catch {
                if let errorData = try? decoder.decode(ErrorResponseModel.self, from: data) {
                    completion(.failure(.backendError(errorData)))
                } else {
                    completion(.failure(.decodingError))
                }
            }
        }
        .resume()
    }
}
