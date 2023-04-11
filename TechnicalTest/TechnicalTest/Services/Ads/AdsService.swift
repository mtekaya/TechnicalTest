//
//  AdsService.swift
//  TechnicalTest
//
//  Created by Marouene on 08/04/2023.
//

import Foundation
import Combine

class AdsService: AdsServiceProtocol {

    #warning("to remove and replace with DI")
    static let shared: AdsServiceProtocol = AdsService()
    
    init() {}
    
    func getAds() -> AnyPublisher<[Advertisement], Error> {
        guard let url = URL(string: ApiConstants.baseURL + ApiConstants.Paths.ads.rawValue) else {
            return Fail(error: ApiConstants.ServerError.malformattedURL).eraseToAnyPublisher()
        }
        var jsondecoder = JSONDecoder()
        jsondecoder.dateDecodingStrategy = .iso8601
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw ApiConstants.ServerError.noData
                }
                return output.data
            }
            .decode(type: [Advertisement].self, decoder: jsondecoder)
            .eraseToAnyPublisher()
    }
}
