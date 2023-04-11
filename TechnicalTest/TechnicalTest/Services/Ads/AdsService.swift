//
//  AdsService.swift
//  TechnicalTest
//
//  Created by Marouene on 08/04/2023.
//

import Foundation


class AdsService: AdsServiceProtocol {
        
    #warning("to remove and replace with DI")
    static let shared: AdsServiceProtocol = AdsService()
    
    init() {}
    
    func getAds(_ completion: @escaping ([Advertisement]?, Error?) -> Void) {
        guard let url = URL(string: ApiConstants.baseURL + ApiConstants.Paths.ads.rawValue) else {
            completion(nil, ApiConstants.ServerError.malformattedURL)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        performRequest(request) { data, error  in
            guard let data = data, let response = try? JSONDecoder().decode([Advertisement].self, from: data) else {
                completion(nil, error ?? ApiConstants.ServerError.noData)
                return
            }
            completion(response, nil)
        }
    }

    
    private func performRequest(_ request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request) { (data, _, error) in
            completion(data, error)
        }
        dataTask.resume()
    }
}
