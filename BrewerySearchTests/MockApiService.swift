//
//  MockApiService.swift
//  BrewerySearchTests
//
//  Created by Robert Faist on 2/13/23.
//

import Foundation
import CoreLocation
@testable import BrewerySearch

class MockApiService: OpenBreweryAPI {
    var payload: [Brewery] = []
    var mockError: Bool = false
    var error: NetworkError = .responseError
    
    private let testDataHelper = TestDataHelper()
    
    func getBreweries(by type: BrewerySearch.BreweryType) async throws -> Result<[BrewerySearch.Brewery], Error> {
        mockResult()
    }
    
    func getBreweries(at coordinate: CLLocation) async throws -> Result<[BrewerySearch.Brewery], Error> {
        mockResult()
    }
    
    private func mockResult() -> Result<[BrewerySearch.Brewery], Error> {
        guard !mockError else { return .failure(error) }
        payload = testDataHelper.testBreweries ?? []
        return .success(payload)
    }
}
