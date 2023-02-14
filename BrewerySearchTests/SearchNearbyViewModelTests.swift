//
//  SearchNearbyViewModelTests.swift
//  BrewerySearchTests
//
//  Created by Robert Faist on 2/13/23.
//

import XCTest
@testable import BrewerySearch

final class SearchNearbyViewModelTests: XCTestCase {
    
    var viewModel: SearchNearbyViewModel!
    var apiService: MockApiService!

    override func setUp() {
        apiService = MockApiService()
        viewModel = SearchNearbyViewModel(openBreweryAPI: apiService)
    }
    
    func test_labels() {
        XCTAssertEqual("Error", viewModel.errorTitle)
    }
    
    func test_searchNearbyError() async {
        apiService.mockError = true
        apiService.error = NetworkError.decodeError
        
        await viewModel.searchNearby()
        
        XCTAssertEqual(0, viewModel.breweries.count)
        XCTAssertTrue(viewModel.hasLocationError)
    }
    
    func test_searchNearbySuccess() async {
        apiService.mockError = false
        
        await viewModel.searchNearby()
        
        XCTAssertEqual(3, viewModel.breweries.count)
        XCTAssertFalse(viewModel.hasLocationError)
    }
}
