//
//  CategoriesService.swift
//  TechnicalTest
//
//  Created by Marouene on 08/04/2023.
//  Copyright © 2023 Marouene. All rights reserved.
//

import Foundation
import Combine

class CategoriesService: CategoriesServiceProtocol {    
    func getCategories() -> AnyPublisher<[Category], Error> {
        guard let url = URL(string: ApiConstants.baseURL + ApiConstants.Paths.categories.rawValue) else {
            return Fail(error: ApiConstants.ServerError.malformattedURL).eraseToAnyPublisher()
        }
    
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse,
                        response.statusCode == 200 else {
                    throw ApiConstants.ServerError.noData
                }
                
                return output.data
            }
            .decode(type: [Category].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}


