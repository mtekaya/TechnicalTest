//
//  CategoriesService.swift
//  TechnicalTest
//
//  Created by compte temporaire on 08/04/2023.
//  Copyright © 2023 Marouene. All rights reserved.
//

import Foundation

class CategoriesService: CategoriesServiceProtocol {
#warning("to remove and replace with DI")
    static let shared: CategoriesServiceProtocol = CategoriesService()
    
    init() {}
    
    func getCategories(_ completion: @escaping ([Category]?, Error?) -> Void) {
        guard let url = URL(string: ApiConstants.baseURL + ApiConstants.Paths.categories.rawValue) else {
            completion(nil, ApiConstants.ServerError.malformattedURL)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        performRequest(request) { data, error  in
            guard let data = data, let response = try? JSONDecoder().decode([Category].self, from: data) else {
                completion(nil, error ?? ApiConstants.ServerError.noData)
                return
            }
            completion(response, nil)
        }
    }
    
    #warning("duplicated")
    private func performRequest(_ request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request) { (data, _, error) in
            completion(data, error)
        }
        dataTask.resume()
    }
}
