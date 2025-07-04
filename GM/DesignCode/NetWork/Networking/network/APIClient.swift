//
//  APIClient.swift
//  RequestURL
//
//  Created by huytd - huyduc.dev
//  Copyright © 2022 ethos. All rights reserved.
//

import Foundation

public class APIClient {
    
   static func buildURLRequest<T: APIRequest>(for request: T) throws -> URLRequest {
        return try URLRequestBuilder(with: request.baseURL, path: request.path)
            .set(method: request.method)
            .set(headers: request.headers)
            .set(parameters: request.parameters)
            .build()
    }
}
