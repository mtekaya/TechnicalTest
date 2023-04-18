//
//  HomeViewModel.swift
//  TechnicalTest
//
//  Created by Marouene on 11/04/2023.
//

import Foundation
import Combine

struct RichAdvertisement: Hashable {
    let category: Category
    let title: String
    let description: String
    let price: Double
    let imagesURL: Image
    let creationDate: Date
    let isUrgent: Bool
    let siret: String?
}

protocol HomeViewModelProtocol {
    func getCategories() -> CurrentValueSubject<[Category], Error>
    func getData() -> AnyPublisher<[RichAdvertisement], Error>
    func setcategory(selectedCategory: Int?)
    func setSortByDateAscendant(ascendant: Bool)
}

class HomeViewModel: HomeViewModelProtocol {
    private var cancellables = Set<AnyCancellable>()
    private let adsService: AdsServiceProtocol
    private let categoriesService: CategoriesServiceProtocol
    private let selectedCategory = CurrentValueSubject<Int?, Error>(nil)
    private let sortByDateAscendant = CurrentValueSubject<Bool, Error>(false)
    private let categoriesSubject = CurrentValueSubject<[Category], Error>([])
    
    init(adsService: AdsServiceProtocol, categoriesService: CategoriesServiceProtocol) {
        self.adsService = adsService
        self.categoriesService = categoriesService
    }
    
    func setcategory(selectedCategory: Int?) {
        self.selectedCategory.send(selectedCategory)
    }
    
    func setSortByDateAscendant(ascendant: Bool) {
        sortByDateAscendant.send(ascendant)
    }

    func getCategories() -> CurrentValueSubject<[Category], Error> {
        categoriesSubject
    }
    
    private func getCategoriesPublisher() -> AnyPublisher<[Category], Error> {
        categoriesService
            .getCategories()
            .map { [weak self] categories in
                self?.categoriesSubject.send(categories)
                return categories
            }.eraseToAnyPublisher()
    }
    
    func getData() -> AnyPublisher<[RichAdvertisement], Error> {
        return Publishers.CombineLatest4(
            getCategoriesPublisher(),
            adsService
                .getAds(),
            selectedCategory,
            sortByDateAscendant
        ).map { (categories, advertissements, selectedCategory, sortByDateAscendant) in
            let categoriesSet = Set<Category>(categories)
            let homeData: [RichAdvertisement] = advertissements
                .compactMap { advertisement in
                    guard selectedCategory == nil || advertisement.categoryID == selectedCategory,
                          let currentCategory = categoriesSet
                        .first(
                            where: {
                                $0.id == advertisement.categoryID
                            }
                        ) else { return nil }
                    
                    return RichAdvertisement(
                        category: currentCategory,
                        title: advertisement.title,
                        description: advertisement.description,
                        price: advertisement.price,
                        imagesURL: advertisement.imagesURL,
                        creationDate: advertisement.creationDate,
                        isUrgent: advertisement.isUrgent,
                        siret: advertisement.siret
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
