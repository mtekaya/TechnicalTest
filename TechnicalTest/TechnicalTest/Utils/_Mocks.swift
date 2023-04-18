//
//  _Mocks.swift
//  TechnicalTestTests
//
//  Created by Marouene on 18/04/2023.
//

import Foundation
import Combine

enum _Mocks {
    static let advertisement1cat1: Advertisement = .init(
        id: 1,
        categoryID: 1,
        title: "test title",
        description: "test description",
        price: 1,
        imagesURL: .init(
            small: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/Un1.svg/768px-Un1.svg.png",
            thumb: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/Un1.svg/768px-Un1.svg.png"
        ),
        creationDate: Date().addingTimeInterval(1),
        isUrgent: false,
        siret: "siret"
    )
    
    static let advertisement2cat1: Advertisement = .init(
        id: 2,
        categoryID: 1,
        title: "test title2",
        description: "test description2",
        price: 1,
        imagesURL: .init(
            small: "https://st2.depositphotos.com/1001311/5495/i/950/depositphotos_54959697-stock-photo-golden-shining-metallic-3d-symbol.jpg",
            thumb: "https://st2.depositphotos.com/1001311/5495/i/950/depositphotos_54959697-stock-photo-golden-shining-metallic-3d-symbol.jpg"
        ),
        creationDate: Date().addingTimeInterval(2),
        isUrgent: true,
        siret: nil
    )
    
    static let advertisement3cat1: Advertisement = .init(
        id: 3,
        categoryID: 1,
        title: "test title3",
        description: "test description3",
        price: 1,
        imagesURL: .init(
            small: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/25/NYCS-bull-trans-3.svg/1200px-NYCS-bull-trans-3.svg.png",
            thumb: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/25/NYCS-bull-trans-3.svg/1200px-NYCS-bull-trans-3.svg.png"
        ),
        creationDate: Date().addingTimeInterval(3),
        isUrgent: true,
        siret: nil
    )
    
    static let advertisement4cat2: Advertisement = .init(
        id: 4,
        categoryID: 2,
        title: "test title4",
        description: "test description4",
        price: 1,
        imagesURL: .init(
            small: "",
            thumb: ""
        ),
        creationDate: Date().addingTimeInterval(4),
        isUrgent: false,
        siret: nil
    )
    
    static let advertisement5cat2: Advertisement = .init(
        id: 5,
        categoryID: 2,
        title: "test title5",
        description: "test description5",
        price: 1,
        imagesURL: .init(
            small: "",
            thumb: ""
        ),
        creationDate: Date().addingTimeInterval(5),
        isUrgent: true,
        siret: nil
    )
    
    static let advertisement6cat2: Advertisement = .init(
        id: 6,
        categoryID: 2,
        title: "test title6",
        description: "test description6",
        price: 1,
        imagesURL: .init(
            small: "",
            thumb: ""
        ),
        creationDate: Date().addingTimeInterval(6),
        isUrgent: true,
        siret: nil
    )
    
    static let categorie1: Category = .init(id: 1, name: "Catégorie 1")
    static let categorie2: Category = .init(id: 2, name: "Catégorie 2")
    static let categorie3: Category = .init(id: 3, name: "Catégorie 3")
}


class _MockAdsTestService: AdsServiceProtocol {
    private var testAdvertissements: [Advertisement] = [
        _Mocks.advertisement1cat1,
        _Mocks.advertisement2cat1,
        _Mocks.advertisement3cat1,
        _Mocks.advertisement4cat2,
        _Mocks.advertisement5cat2,
        _Mocks.advertisement6cat2
    ]
    
    func setAdvertisement(_ ads: [Advertisement]) {
        testAdvertissements = ads
    }
    
    func getAds() -> AnyPublisher<[Advertisement], Error> {
        return Just(testAdvertissements)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

class _MockCategoriesService: CategoriesServiceProtocol {
    private var testCategories: [Category] = [
        _Mocks.categorie1,
        _Mocks.categorie2,
        _Mocks.categorie3
    ]
    
    func setCategories(_ categories: [Category]) {
        testCategories = categories
    }
    
    func getCategories() -> AnyPublisher<[Category], Error> {
        return Just(testCategories)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
