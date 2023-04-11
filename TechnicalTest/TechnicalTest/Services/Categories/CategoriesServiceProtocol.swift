//
//  CategoriesServiceProtocol.swift
//  TechnicalTest
//
//  Created by compte temporaire on 08/04/2023.
//  Copyright © 2023 Marouene. All rights reserved.
//

import Foundation

protocol CategoriesServiceProtocol {
    func getCategories(_ completion: @escaping ([Category]?, Error?) -> Void)
}
