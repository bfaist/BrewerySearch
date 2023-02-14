//
//  BreweryView.swift
//  BrewerySearch
//
//  Created by Robert Faist on 1/23/23.
//

import SwiftUI

struct BreweryView: View {
    @ObservedObject var viewModel: BreweryViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(viewModel.brewery.name).bold()
                if let url = viewModel.url {
                    shareIcon.onTapGesture { UIApplication.shared.open(url) }
                }
            }
            address
        }.padding()
    }
    
    var shareIcon: Image {
        Image(systemName: "square.and.arrow.up")
    }
    
    var address: some View {
        VStack(alignment: .leading) {
            if viewModel.brewery.street != nil {
                Text(viewModel.brewery.street ?? "")
            }
            Text("\(viewModel.brewery.city), \(viewModel.brewery.state ?? "Unknown State") \(viewModel.brewery.postalCode)")
        }
    }
}
