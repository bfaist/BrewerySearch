//
//  SearchViewModelTests.swift
//  BrewerySearchTests
//
//  Created by Robert Faist on 2/13/23.
//

import XCTest
@testable import BrewerySearch

final class SearchViewModelTests: XCTestCase {
    
    var viewModel: SearchViewModel!

    override func setUp() {
        viewModel = SearchViewModel()
    }

    func test_labels() {
        XCTAssertEqual("Brewery Search", viewModel.headerTitle)
        XCTAssertEqual("Search Nearby", viewModel.searchNearbyTitle)
        XCTAssertEqual("Search by Type", viewModel.searchByTypeTitle)
    }
}
