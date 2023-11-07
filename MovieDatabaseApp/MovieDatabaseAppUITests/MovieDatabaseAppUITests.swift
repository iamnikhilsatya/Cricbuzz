//
//  MovieDatabaseAppUITests.swift
//  MovieDatabaseAppUITests
//
//  Created by yalla lalitesh on 02/11/23.
//

import XCTest

final class MovieDatabaseAppUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app.terminate()
        super.tearDown()
    }

    func testSearch() {
        // Tap the search field and enter a search query
        let searchField = app.textFields[" Search movies"]
        XCTAssertTrue(searchField.waitForExistence(timeout: 5))
        searchField.tap()
        searchField.typeText("Action")

        // Verify that search results are displayed
        let searchResultsHeader = app.staticTexts["Search Results"]
        XCTAssertTrue(searchResultsHeader.exists)
    }
}
