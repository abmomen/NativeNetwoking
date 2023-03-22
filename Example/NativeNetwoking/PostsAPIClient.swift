//
//  PostsAPIClient.swift
//  NativeNetwoking_Example
//
//  Created by ST-iOS on 2/6/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import NativeNetwoking

private struct PostsEndPoint: EndPoint {
    var baseUrl: String {
        return "https://jsonplaceholder.typicode.com"
    }
    
    var path: String {
        return "/posts"
    }
}

struct PostsAPIClient: GenericAPIClient {    
    static func fetchPosts(completion: @escaping (Result<[Post]?, ErrorModel>) -> Void) {
        startRequest(with: PostsEndPoint(), completion: completion)
    }
}
