//
//  CategoriesServiceProtocol.swift
//  TechnicalTest
//
//  Created by compte temporaire on 08/04/2023.
//  Copyright © 2023 Marouene. All rights reserved.
//

import Foundation
import Combine

protocol CategoriesServiceProtocol {
    func getCategories() -> AnyPublisher<[Category], Error>
}
