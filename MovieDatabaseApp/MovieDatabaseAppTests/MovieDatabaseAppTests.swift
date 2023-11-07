//
//  MovieDatabaseAppTests.swift
//  MovieDatabaseAppTests
//
//  Created by yalla lalitesh on 02/11/23.
//

import XCTest
@testable import MovieDatabaseApp

final class MoviesViewModelTests: XCTestCase {
    var viewModel: MoviesViewModel!

    override func setUp() {
        super.setUp()
        viewModel = MoviesViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    // Test if movies are loaded from the JSON file correctly.
    func testMoviesLoaded() {
        XCTAssertFalse(viewModel.movies.isEmpty)
    }

    // Test if generating list items works as expected.
    func testGenerateListItem() {
        viewModel.generateListItem()
        XCTAssertFalse(viewModel.listItem.isEmpty)
    }

    // Test filtering movies based on a category and filter.
    func testGetMovies() {
        let yearFilter = "2000"
        let genreFilter = "Action"
        let directorFilter = "Jay Roach"
        let actorFilter = "Joe Penny"

        let yearMovies = viewModel.getMovies(category: "Year", filter: yearFilter)
        let genreMovies = viewModel.getMovies(category: "Genre", filter: genreFilter)
        let directorMovies = viewModel.getMovies(category: "Directors", filter: directorFilter)
        let actorMovies = viewModel.getMovies(category: "Actors", filter: actorFilter)

        XCTAssertFalse(yearMovies.isEmpty)
        XCTAssertFalse(genreMovies.isEmpty)
        XCTAssertFalse(directorMovies.isEmpty)
        XCTAssertFalse(actorMovies.isEmpty)
    }

    // Test clearing search results.
    func testClearSearchResults() {
        viewModel.performSearch(query: "search query")
        viewModel.clearSearchResults()
        XCTAssertTrue(viewModel.searchResults.isEmpty)
    }

    // Test performing a search.
    func testPerformSearch() {
        let query = "Race"
        viewModel.performSearch(query: query)
        XCTAssertTrue(viewModel.searchResults.count > 0)
    }

    // Test filtering movies based on the selected filter.
    func testFilteredMovies() {
        viewModel.selectedFilter = .year("2000")
        let filteredMovies = viewModel.filteredMovies
        XCTAssertFalse(filteredMovies.isEmpty)
    }
}
