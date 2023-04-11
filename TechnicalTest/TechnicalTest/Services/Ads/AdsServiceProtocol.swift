//
//  AdsServiceProtocol.swift
//  TechnicalTest
//
//  Created by Marouene on 08/04/2023.
//

import Foundation

protocol AdsServiceProtocol {
    func getAds(_ completion: @escaping ([Advertisement]?, Error?) -> Void)
}
