//
//  Brewery.swift
//  BrewerySearch
//
//  Created by Robert Faist on 1/23/23.
//

import Foundation

enum BreweryType: String, Codable, CaseIterable, Equatable {
    case regional
    case large
    case micro
    case closed
    case nano
    case brewpub
    case planning
    case bar
    case contract
    case proprietor
    case proprieter
}

struct Brewery: Codable, Identifiable {
    let id: String
    let name: String
    let breweryType: BreweryType
    let street: String?
    let address2: String?
    let address3: String?
    let city: String
    let state: String?
    let countyProvince: String?
    let postalCode: String
    let country: String
    let longitude: String?
    let latitude: String?
    let phone: String?
    let websiteUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case breweryType = "brewery_type"
        case street
        case address2 = "address_2"
        case address3 = "address_3"
        case city
        case state
        case countyProvince = "county_province"
        case postalCode = "postal_code"
        case country
        case longitude
        case latitude
        case phone
        case websiteUrl = "website_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        breweryType = try values.decode(BreweryType.self, forKey: .breweryType)
        street = try values.decode(String?.self, forKey: .street)
        address2 = try values.decode(String?.self, forKey: .address2)
        address3 = try values.decode(String?.self, forKey: .address3)
        city = try values.decode(String.self, forKey: .city)
        state = try values.decode(String?.self, forKey: .state)
        countyProvince = try values.decode(String?.self, forKey: .countyProvince)
        postalCode = try values.decode(String.self, forKey: .postalCode)
        country = try values.decode(String.self, forKey: .country)
        longitude = try values.decode(String?.self, forKey: .longitude)
        latitude = try values.decode(String?.self, forKey: .latitude)
        phone = try values.decode(String?.self, forKey: .phone)
        websiteUrl = try values.decode(String?.self, forKey: .websiteUrl)
    }
}

extension Array where Element.Type == Brewery.Type {
    func sortedByZipcode() -> [Brewery] {
        self.sorted(by: { Int($0.postalCode) ?? 0 < Int($1.postalCode) ?? 0 })
    }
    
    func sortedByName() -> [Brewery] {
        self.sorted(by: { $0.name < $1.name })
    }
}
