//
//  HomeViewModel.swift
//  TechnicalTest
//
//  Created by compte temporaire on 11/04/2023.
//

import Foundation
import Combine

struct HomeCellData: Hashable {
    let category: Category
    let title: String
    let price: Double
    let imagesURL: Image
    let creationDate: Date
    let isUrgent: Bool
}


class HomeViewModel {
    private let diContainer: DIContainer
    let selectedCategory = CurrentValueSubject<Int?, Error>(nil)
    let sortByDateAscendant = CurrentValueSubject<Bool, Error>(false)

    init(diContainer: DIContainer) {
        self.diContainer = diContainer
    }
    
    func setcategory(selectedCategory: Int?) {
        self.selectedCategory.send(selectedCategory)
    }
    
    func getData() -> AnyPublisher<[HomeCellData], Error> {
        let categoriesPublisher = diContainer.categoriesService
            .getCategories().share()
        
        let adsPublisher = diContainer.adsService
            .getAds().share()
        
        return Publishers.CombineLatest4(
            categoriesPublisher,
            adsPublisher,
            selectedCategory,
            sortByDateAscendant
        ).map { (categories, advertissements, selectedCategory, sortByDateAscendant) in
            let categoriesSet = Set<Category>(categories)
            let homeData: [HomeCellData] = advertissements
                .compactMap { advertisement in
                    guard selectedCategory == nil || advertisement.categoryID == selectedCategory,
                          let currentCategory = categoriesSet
                        .first(
                            where: {
                                $0.id == advertisement.categoryID
                            }
                        ) else { return nil }
                    
                    return HomeCellData(
                        category: currentCategory,
                        title: advertisement.title,
                        price: advertisement.price,
                        imagesURL: advertisement.imagesURL,
                        creationDate: advertisement.creationDate,
                        isUrgent: advertisement.isUrgent
                    )
                }
            let sorted = homeData.sorted { (lhs, rhs) -> Bool in
                if lhs.isUrgent == rhs.isUrgent {
                    return (sortByDateAscendant && lhs.creationDate < rhs.creationDate) ||
                    (!sortByDateAscendant && lhs.creationDate > rhs.creationDate)
                }
                
                return lhs.isUrgent
            }
            return sorted
        }
        .eraseToAnyPublisher()
    }
}
