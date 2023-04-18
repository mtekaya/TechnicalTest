//
//  TechnicalTestUITests.swift
//  TechnicalTestUITests
//
//  Created by Marouene on 07/04/2023.
//

import XCTest

final class TechnicalTestUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-mock"]
        app.launch()
    }
    
    func testFilterCategoryExample() throws {
        
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        XCTAssert(collectionViewsQuery.cells.count == 6)

        let technicaltestHomeviewNavigationBar = app.navigationBars["TechnicalTest.HomeView"]
        let filtreButton = technicaltestHomeviewNavigationBar.buttons["Filtre"]
        filtreButton.tap()
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.buttons["Catégorie 3"].tap()
        XCTAssert(collectionViewsQuery.cells.count == 0)
        
        filtreButton.tap()
        elementsQuery.buttons["Catégorie 2"].tap()
        XCTAssert(collectionViewsQuery.cells.count == 3)

        filtreButton.tap()
        elementsQuery.buttons["Catégorie 1"].tap()
        XCTAssert(collectionViewsQuery.cells.count == 3)

        filtreButton.tap()
        elementsQuery.buttons["Toutes les catégories"].tap()

        
        
        // advertisement 6
        collectionViewsQuery.staticTexts["test title6"].tap()
        let siretPredicate = NSPredicate(format: "label CONTAINS[c] %@", "Siret")

        XCTAssert(app.staticTexts.containing(siretPredicate).count == 0)
        
        
        let backButton = app.navigationBars["TechnicalTest.AdvertisementDetailView"].buttons["Back"]
        backButton.tap()
        // advertisement 1
        collectionViewsQuery.staticTexts["test title"].tap()

        XCTAssert(app.staticTexts.containing(siretPredicate).count > 0)

        
        backButton.tap()
        // advertisement 5
        collectionViewsQuery.staticTexts["test title5"].tap()

        XCTAssert(app.staticTexts.containing(siretPredicate).count == 0)
        
        backButton.tap()

        technicaltestHomeviewNavigationBar.buttons["Tri"].tap()
        
        elementsQuery.buttons["Du plus ancien"].tap()
        // ad2 should be the first cell
        let ads2Predicate = NSPredicate(format: "label CONTAINS[c] %@", "test title2")
        let firstCellStaticTexts = app.collectionViews.children(matching: .cell)
            .element(boundBy: 0)
            .staticTexts
        XCTAssert(firstCellStaticTexts.containing(ads2Predicate).count == 1)
        
    }
}
