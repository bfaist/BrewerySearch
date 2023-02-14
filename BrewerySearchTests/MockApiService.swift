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
    
    func getBreweries(by type: BrewerySearch.BreweryType) async throws -> Result<[BrewerySearch.Brewery], Error> {
        mockResult()
    }
    
    func getBreweries(at coordinate: CLLocation) async throws -> Result<[BrewerySearch.Brewery], Error> {
        mockResult()
    }
    
    private func mockResult() -> Result<[BrewerySearch.Brewery], Error> {
        guard !mockError else { return .failure(error) }
        payload = testData ?? []
        return .success(payload)
    }
    
    private var testData: [Brewery]? {
        guard let data = testJSON.data(using: .utf8) else { return [] }
        return try? JSONDecoder().decode([Brewery].self, from: data)
    }
    
    private let testJSON = """
[{"id":"fretboard-brewing-company-blue-ash","name":"Fretboard Brewing Company","brewery_type":"micro","street":"5800 Creek Rd","address_2":null,"address_3":null,"city":"Blue Ash","state":"Ohio","county_province":null,"postal_code":"45242-4010","country":"United States","longitude":"-84.390108","latitude":"39.260924","phone":"5139144677","website_url":"http://www.fretboardbrewing.com","updated_at":"2023-01-04T04:46:02.393Z","created_at":"2023-01-04T04:46:02.393Z"},{"id":"16-lots-brewing-mason","name":"16 Lots Brewing","brewery_type":"brewpub","street":"753 Reading Rd","address_2":null,"address_3":null,"city":"Mason","state":"Ohio","county_province":null,"postal_code":"45040-1303","country":"United States","longitude":"-84.3183801","latitude":"39.3545967","phone":"5134863672","website_url":"http://www.16lots.com","updated_at":"2023-01-04T04:46:02.393Z","created_at":"2023-01-04T04:46:02.393Z"},{"id":"madtree-brewing-20-cincinnati","name":"MadTree Brewing 2.0","brewery_type":"regional","street":"5164 Kennedy Ave","address_2":null,"address_3":null,"city":"Cincinnati","state":"Ohio","county_province":null,"postal_code":"45213","country":"United States","longitude":"-84.4137736","latitude":"39.1885752","phone":"5138368733","website_url":"http://www.madtreebrewing.com","updated_at":"2023-01-04T04:46:02.393Z","created_at":"2023-01-04T04:46:02.393Z"}]
"""
}
