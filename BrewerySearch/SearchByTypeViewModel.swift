//
//  SearchByTypeViewModel.swift
//  BrewerySearch
//
//  Created by Robert Faist on 1/24/23.
//

import Foundation

class SearchByTypeViewModel: ObservableObject {
    @Published var selectedType: BreweryType = .bar
    
    @Published var hasNetworkError: Bool = false
    @Published var networkErrorDescription: String?
    @Published var breweries: [Brewery] = []
    
    private let apiService: OpenBreweryAPI
    
    init(apiService: OpenBreweryAPI) {
        self.apiService = apiService
    }
    
    var breweryTypes: [BreweryType] {
        BreweryType.allCases
            .filter({ $0 != BreweryType.proprieter && $0 != BreweryType.proprietor })
            .sorted(by: { $0.rawValue < $1.rawValue })
    }
    
    let pickerTitle = "Select Brewery Type"
    let errorTitle = "Error"
    
    func labelText(from type: BreweryType) -> String {
        type.rawValue.capitalized
    }
    
    func fetchBreweries() async {
        do {
            let apiResult = try await apiService.getBreweries(by: selectedType)
            await MainActor.run {
                switch apiResult {
                case .success(let breweries):
                    self.breweries = breweries
                case .failure(let error):
                    self.breweries = []
                    hasNetworkError = true
                    networkErrorDescription = error.localizedDescription
                }
            }
        } catch {
            hasNetworkError = true
            networkErrorDescription = error.localizedDescription
        }
    }
}
