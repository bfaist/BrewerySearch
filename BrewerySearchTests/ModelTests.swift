//
//  ModelTests.swift
//  BrewerySearchTests
//
//  Created by Robert Faist on 2/14/23.
//

import XCTest
@testable import BrewerySearch

class ModelTests: XCTest {
    func testBreweryInit() {
        let testDataHelper = TestDataHelper()
        
        let breweryData = testDataHelper.breweryJSON.data(using: .utf8)!
        var brewery: Brewery?
        
        do {
            brewery = try JSONDecoder().decode(Brewery.self, from: breweryData)
        } catch {
            XCTFail("Failed Brewery JSON decode")
        }
        
        XCTAssertEqual("16 Lots Brewing", brewery?.name)
        XCTAssertEqual(BreweryType.brewpub, brewery?.breweryType)
        XCTAssertEqual("Mason", brewery?.city)
        XCTAssertEqual("Ohio", brewery?.state)
        XCTAssertEqual(nil, brewery?.address2)
    }
}
