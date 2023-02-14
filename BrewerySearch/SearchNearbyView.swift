//
//  SearchNearbyView.swift
//  BrewerySearch
//
//  Created by Robert Faist on 2/5/23.
//

import SwiftUI

struct SearchNearbyView: View {
    @StateObject var viewModel: SearchNearbyViewModel
    
    var body: some View {
        VStack {
            BreweryListView(viewModel: BreweryListViewModel(breweries: viewModel.breweries))
        }.onAppear {
            Task {
                await viewModel.searchNearby()
            }
        }.alert(isPresented: $viewModel.hasLocationError) {
            Alert(title: Text(viewModel.errorTitle),
                  message: Text(viewModel.locationError ?? ""),
                  dismissButton: .cancel())
        }
    }
}
