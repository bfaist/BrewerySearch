//
//  BreweryViewModel.swift
//  BrewerySearch
//
//  Created by Robert Faist on 1/23/23.
//

import Foundation

class BreweryViewModel: ObservableObject {
    @Published var brewery: Brewery
    
    init(brewery: Brewery) {
        self.brewery = brewery
    }
    
    var url: URL? {
        guard let url = brewery.websiteUrl else { return nil }
        return URL(string: url)
    }
}
