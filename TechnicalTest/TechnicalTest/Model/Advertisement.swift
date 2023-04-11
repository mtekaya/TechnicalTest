//
//  Advertisement.swift
//  TechnicalTest
//
//  Created by Marouene on 08/04/2023.
//

import Foundation

struct Advertisement: Codable {
    let id: Int
    let categoryID: Int
    let title, description: String
    let price: Float
    let imagesURL: Image
    let creationDate: Date
    let isUrgent: Bool
    let siret: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case title, description, price
        case imagesURL = "images_url"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
        case siret
    }
}
