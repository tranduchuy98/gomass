//
//  Service.swift
//  RequestURL
//
//  Created by huytd - huyduc.dev
//  Copyright © 2022 ethos. All rights reserved.
//

import Foundation

typealias RequestCallback = (Data?, URLResponse?, Error?) -> Void

public class CategoriesService {

    static func getQuotesInCategories(path: String,completion: @escaping  RequestCallback) {
        let urlRequestBuilder:URLRequestBuilder = URLRequestBuilder.init(with: path, path: "")
        urlRequestBuilder.set(method: .get)
        let urlRequest = try! urlRequestBuilder.build()

        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, response, error)
            }
        })
        task.resume()
    }
}

