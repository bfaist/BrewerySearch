//
//  SearchNearbyViewModel.swift
//  BrewerySearch
//
//  Created by Robert Faist on 2/5/23.
//

import Foundation
import CoreLocation
import Combine

class SearchNearbyViewModel: ObservableObject {
    @Published var breweries: [Brewery] = []
    @Published var lastLocation: CLLocation?
    @Published var hasLocationError: Bool = false
    @Published var locationError: String?
    @Published var networkError: String?
     
    private let openBreweryAPI: OpenBreweryAPI
    private let locationManager: LocationManager
    
    let errorTitle = "Error"
    
    init(openBreweryAPI: OpenBreweryAPI = OpenBreweryAPIImpl(),
         locationManager: LocationManager = LocationManagerImpl()) {
        self.openBreweryAPI = openBreweryAPI
        self.locationManager = locationManager
    }
    
    func searchNearby() async {
        do {
            if let lastLocation = try await locationManager.getLastLocation() {
                let apiResult = try await openBreweryAPI.getBreweries(at: lastLocation)
                
                await MainActor.run {
                    switch apiResult {
                    case .success(let breweries):
                        self.breweries = breweries
                    case .failure(let error):
                        hasLocationError = true
                        self.networkError = error.localizedDescription
                    }
                }
            } else {
                networkError = LocationManagerError.locationNotFound.localizedDescription
                hasLocationError = true
            }
        } catch {
            networkError = LocationManagerError.locationNotFound.localizedDescription
            hasLocationError = true
        }
    }
}
