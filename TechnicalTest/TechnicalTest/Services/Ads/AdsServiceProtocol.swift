//
//  AdsServiceProtocol.swift
//  TechnicalTest
//
//  Created by Marouene on 08/04/2023.
//

import Foundation
import Combine

protocol AdsServiceProtocol {
    func getAds() -> AnyPublisher<[Advertisement], Error>
}
