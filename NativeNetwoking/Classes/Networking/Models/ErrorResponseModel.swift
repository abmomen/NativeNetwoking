//
//  ErrorResponseModel.swift
//  URLSessionNetworking
//
//  Created by ST-iOS on 6/28/22.
//

import Foundation

struct ErrorResponseModel: Decodable {
    let code: Int?
    let message: String?
}
