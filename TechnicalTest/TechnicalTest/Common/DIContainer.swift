//
//  DIContainer.swift
//  TechnicalTest
//
//  Created by Marouene on 11/04/2023.
//

import Foundation

class DIContainer {
    
    let categoriesService: CategoriesServiceProtocol
    let adsService: AdsServiceProtocol
    
    private init(categoriesService: CategoriesServiceProtocol, adsService: AdsServiceProtocol) {
        self.categoriesService = categoriesService
        self.adsService = adsService
    }
    
    static func create() -> DIContainer {
        if StartupUtils.shouldRunWithMock() {
            return DIContainer(
                categoriesService: _MockCategoriesService(),
                adsService: _MockAdsTestService()
            )
        } else {
            return DIContainer(
                categoriesService: CategoriesService(),
                adsService: AdsService()
            )
        }
    }
}
