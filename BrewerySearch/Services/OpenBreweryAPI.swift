//
//  OpenBreweryAPI.swift
//  BrewerySearch
//
//  Created by Robert Faist on 1/23/23.
//

import Foundation
import CoreLocation

enum NetworkError: Error {
    case decodeError
    case invalidUrl
    case responseError
}

protocol OpenBreweryAPI {
    func getBreweries(by type: BreweryType) async throws -> Result<[Brewery], Error>
    func getBreweries(at coordinate: CLLocation) async throws -> Result<[Brewery], Error>
}

class OpenBreweryAPIImpl: OpenBreweryAPI {
    private let baseUrl = "https://api.openbrewerydb.org"
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func getBreweries(by type: BreweryType) async throws -> Result<[Brewery], Error> {
        guard var url = URL(string: "\(baseUrl)/breweries") else {
            return .failure(NetworkError.invalidUrl)
        }
        
        let queryItems = [URLQueryItem(name: "by_type", value: type.rawValue)]
        
        url.append(queryItems: queryItems)
        
        return try await getBreweries(url: url)
    }
    
    func getBreweries(at coordinate: CLLocation) async throws -> Result<[Brewery], Error> {
        guard var url = URL(string: "\(baseUrl)/breweries") else {
            return .failure(NetworkError.invalidUrl)
        }
        
        let queryItems = [URLQueryItem(name: "by_dist", value: "\(coordinate.coordinate.latitude),\(coordinate.coordinate.longitude)")]
        
        url.append(queryItems: queryItems)
        
        return try await getBreweries(url: url)
    }
    
    private func getBreweries(url: URL) async throws -> Result<[Brewery], Error> {
        let (data, response) = try await urlSession.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            return .failure(NetworkError.responseError)
        }
        
        var breweries: [Brewery] = []
        
        do {
            breweries = try JSONDecoder().decode([Brewery].self, from: data)
        } catch {
            return .failure(NetworkError.decodeError)
        }
        
        return .success(breweries)
    }
}
