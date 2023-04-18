//
//  Mocks.swift
//  TechnicalTestTests
//
//  Created by Marouene on 18/04/2023.
//

import Foundation

enum Mocks {
    static let advertisement1cat1: Advertisement = .init(
        id: 1,
        categoryID: 1,
        title: "test title",
        description: "test description",
        price: 1,
        imagesURL: .init(
            small: "",
            thumb: ""
        ),
        creationDate: Date().addingTimeInterval(1),
        isUrgent: false,
        siret: nil
    )
    
    static let advertisement2cat1: Advertisement = .init(
        id: 2,
        categoryID: 1,
        title: "test title2",
        description: "test description2",
        price: 1,
        imagesURL: .init(
            small: "",
            thumb: ""
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
            small: "",
            thumb: ""
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
