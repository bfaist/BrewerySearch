//
//  BreweryListViewModel.swift
//  BrewerySearch
//
//  Created by Robert Faist on 2/9/23.
//

import Foundation

class BreweryListViewModel: ObservableObject {
    @Published var breweries: [Brewery]
    
    init(breweries: [Brewery]) {
        self.breweries = breweries
    }
}
