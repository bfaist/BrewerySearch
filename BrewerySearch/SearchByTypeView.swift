//
//  SearchByTypeView.swift
//  BrewerySearch
//
//  Created by Robert Faist on 1/24/23.
//

import SwiftUI

struct SearchByTypeView: View {
    @StateObject var viewModel: SearchByTypeViewModel
    
    var body: some View {
        VStack {
            Picker(viewModel.pickerTitle, selection: $viewModel.selectedType) {
                ForEach(viewModel.breweryTypes, id: \.self) { type in
                    Text(viewModel.labelText(from: type))
                }
            }.pickerStyle(.menu)
            Spacer()
            BreweryListView(viewModel: BreweryListViewModel(breweries: viewModel.breweries))
        }.onReceive(viewModel.$selectedType) { _ in
            Task {
                await viewModel.fetchBreweries()
            }
        }.alert(isPresented: $viewModel.hasNetworkError) {
            let errorDescription = viewModel.networkErrorDescription ?? ""
            return Alert(title: Text(viewModel.errorTitle),
                         message: Text(errorDescription),
                         dismissButton: .cancel())
        }
    }
}
