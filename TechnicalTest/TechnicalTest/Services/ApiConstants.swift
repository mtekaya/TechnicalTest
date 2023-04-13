//
//  ApiConstants.swift
//  TechnicalTest
//
//  Created by Marouene on 08/04/2023.
//  Copyright © 2023 Marouene. All rights reserved.
//

import Foundation

struct ApiConstants {
    
    static let baseURL = "https://raw.githubusercontent.com/leboncoin/paperclip/master/"
    
    enum Paths: String {
        case categories = "categories.json"
        case ads = "listing.json"
    }
    
    enum ServerError: Error {
        case noData
        case malformattedURL
    }
}
