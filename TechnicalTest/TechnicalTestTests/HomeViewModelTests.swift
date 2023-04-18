//
//  HomeViewModelTests.swift
//  TechnicalTestTests
//
//  Created by Marouene on 18/04/2023.
//

import XCTest
import Combine

final class HomeViewModelTests: XCTestCase {
    private let adsService = _MockAdsTestService()
    private let categoriesService = _MockCategoriesService()
    private var cancellables = Set<AnyCancellable>()
    private let expectation = XCTestExpectation(description: "Recieving data.")
    
    private var homeViewModel: HomeViewModel!
    
    override func setUpWithError() throws {
        homeViewModel = HomeViewModel(
            adsService: adsService,
            categoriesService: categoriesService
        )
        
        categoriesService.setCategories([
            _Mocks.categorie1,
            _Mocks.categorie2,
            _Mocks.categorie3
        ])
        adsService.setAdvertisement([
            _Mocks.advertisement1cat1,
            _Mocks.advertisement2cat1,
            _Mocks.advertisement3cat1,
            _Mocks.advertisement4cat2,
            _Mocks.advertisement5cat2,
            _Mocks.advertisement6cat2
        ])
    }
   
    func testEmptyResponseExample() throws {
        adsService.setAdvertisement([])
        homeViewModel.getData().sink { _ in } receiveValue: { ads in
            XCTAssert(ads.isEmpty)
        }.store(in: &cancellables)
        
    }
    
    func testCategoryFilterAndSortExample() throws {
        homeViewModel.setcategory(selectedCategory: 3)
        homeViewModel.getData().sink { _ in } receiveValue: { [unowned self] ads in
            XCTAssert(ads.isEmpty)
            self.expectation.fulfill()
        }.store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }
    
    func testCategoryFilter2SortAscendantExample() throws {
        homeViewModel.setcategory(selectedCategory: 2)
        homeViewModel.setSortByDateAscendant(ascendant: true)
        homeViewModel.getData().sink { _ in }
    receiveValue: { [unowned self] ads in
        XCTAssert(ads.count == 3)
        XCTAssert(
            ads.map(\.category.id)
                .filter({ $0 == 2 })
                .count == 3
        )
        let firstAd = ads[0]
        XCTAssert(firstAd.isUrgent)
        XCTAssert(firstAd.title == "test title5")
        
        let secondAd = ads[1]
        XCTAssert(secondAd.isUrgent)
        XCTAssert(secondAd.title == "test title6")
        
        let thirdAd = ads[2]
        XCTAssertFalse(thirdAd.isUrgent)
        XCTAssert(thirdAd.title == "test title4")
        
        
        self.expectation.fulfill()
    }.store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }
    
    func testCategoryFilter2SortDescendantExample() throws {
        homeViewModel.setcategory(selectedCategory: 2)
        homeViewModel.setSortByDateAscendant(ascendant: false)
        homeViewModel.getData().sink { _ in } receiveValue: { [unowned self] ads in
            XCTAssert(ads.count == 3)
            let firstAd = ads[0]
            XCTAssert(firstAd.isUrgent)
            XCTAssert(firstAd.title == "test title6")
            
            let secondAd = ads[1]
            XCTAssert(secondAd.isUrgent)
            XCTAssert(secondAd.title == "test title5")
            
            let thirdAd = ads[2]
            XCTAssertFalse(thirdAd.isUrgent)
            XCTAssert(thirdAd.title == "test title4")
            
            self.expectation.fulfill()
        }.store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }
    
    func testCategoryFilter3Example() throws {
        homeViewModel.setcategory(selectedCategory: nil)
        homeViewModel.getData().sink { _ in } receiveValue: { [unowned self] ads in
            XCTAssert(ads.count == 6)
            XCTAssert(ads.prefix(4).filter({ $0.isUrgent }).count == 4)
            XCTAssert(ads.suffix(2).filter({ !$0.isUrgent }).count == 2)
            let mappedTitles = ads.map(\.title)
            let expectedTitles = ["test title6", "test title5", "test title3", "test title2", "test title4", "test title"]
            XCTAssert(mappedTitles == expectedTitles)
            self.expectation.fulfill()
        }.store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }
}


