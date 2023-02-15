//
//  ContentView.swift
//  BrewerySearch
//
//  Created by Robert Faist on 1/23/23.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    @State var searchByTypeActive = false
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    NavigationLink {
                        SearchByTypeView(viewModel: SearchByTypeViewModel(apiService: OpenBreweryAPIImpl()))
                    } label: {
                        Image(systemName: "filemenu.and.selection")
                        Text(viewModel.searchByTypeTitle)
                    }
                    NavigationLink {
                        SearchNearbyView(viewModel: SearchNearbyViewModel(openBreweryAPI: OpenBreweryAPIImpl(),
                                                                          locationManager: LocationManagerImpl()))
                    } label: {
                        Image(systemName: "location.fill")
                        Text(viewModel.searchNearbyTitle)
                    }
                }.listStyle(.plain)
                 .navigationTitle(viewModel.headerTitle)
            }
            .padding()
        }.onAppear {
            viewModel.requestLocationPermission()
        }
    }
}
