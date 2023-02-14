//
//  SearchByTypeViewModelTests.swift
//  BrewerySearchTests
//
//  Created by Robert Faist on 2/13/23.
//

import XCTest
@testable import BrewerySearch

final class SearchByTypeViewModelTests: XCTestCase {
    
    var viewModel: SearchByTypeViewModel!
    var apiService: MockApiService!

    override func setUp() {
        apiService = MockApiService()
        viewModel = SearchByTypeViewModel(apiService: apiService)
    }

    func test_breweryTypes() {
        XCTAssertEqual(9, viewModel.breweryTypes.count)
        XCTAssertFalse(viewModel.breweryTypes.contains(where: { $0 == BreweryType.proprietor || $0 == BreweryType.proprieter }))
    }
    
    func test_labels() {
        XCTAssertEqual("Select Brewery Type", viewModel.pickerTitle)
        XCTAssertEqual("Error", viewModel.errorTitle)
    }
    
    func test_labelForType() {
        XCTAssertEqual("Brewpub", viewModel.labelText(from: .brewpub))
        XCTAssertEqual("Nano", viewModel.labelText(from: .nano))
        XCTAssertEqual("Bar", viewModel.labelText(from: .bar))
        XCTAssertEqual("Closed", viewModel.labelText(from: .closed))
        XCTAssertEqual("Contract", viewModel.labelText(from: .contract))
        XCTAssertEqual("Large", viewModel.labelText(from: .large))
        XCTAssertEqual("Micro", viewModel.labelText(from: .micro))
        XCTAssertEqual("Planning", viewModel.labelText(from: .planning))
        XCTAssertEqual("Regional", viewModel.labelText(from: .regional))
    }
    
    func test_fetchWithError() async {
        apiService.mockError = true
        apiService.error = NetworkError.decodeError
        
        await viewModel.fetchBreweries()
        
        XCTAssertEqual(0, viewModel.breweries.count)
        XCTAssertEqual(true, viewModel.hasNetworkError)
    }
    
    func test_fetchSuccess() async {
        apiService.mockError = false
        
        await viewModel.fetchBreweries()
        
        XCTAssertEqual(viewModel.breweries.count, 3)
        XCTAssertEqual(false, viewModel.hasNetworkError)
    }
}
