//
//  SearchViewModel.swift
//  BrewerySearch
//
//  Created by Robert Faist on 1/24/23.
//

import Foundation

class SearchViewModel: ObservableObject {
    let searchByTypeTitle = "Search by Type"
    let searchNearbyTitle = "Search Nearby"
    let headerTitle = "Brewery Search"
    
    private let locationManager: LocationManager
    
    init(locationManager: LocationManager = LocationManagerImpl()) {
        self.locationManager = locationManager
    }
    
    func requestLocationPermission() {
        Task {
            await locationManager.requestPermission()
        }
    }
}
