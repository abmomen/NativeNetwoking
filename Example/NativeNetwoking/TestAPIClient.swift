//
//  TestAPIClient.swift
//  NativeNetwoking_Example
//
//  Created by ST-iOS on 2/6/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import NativeNetwoking

private struct TestEndPoint: EndPoint {
    var baseUrl: String {
        return ""
    }
    
    var path: String {
        return ""
    }
}

struct TestAPIClient: GenericAPIClient {
    static func fetchData(completion: @escaping (Result<String, ErrorModel>) -> Void) {
        startRequest(with: TestEndPoint(), completion: completion)
    }
}
