//
//  BreweryListView.swift
//  BrewerySearch
//
//  Created by Robert Faist on 2/9/23.
//

import SwiftUI

struct BreweryListView: View {
    @ObservedObject var viewModel: BreweryListViewModel
    
    var body: some View {
        List($viewModel.breweries) { brewery in
            BreweryView(viewModel: BreweryViewModel(brewery: brewery.wrappedValue))
        }.listStyle(.plain)
    }
}
