//
//  AddLocationView.swift
//  EZ Parker
//
//  Created by Minh Duc Pham on 2024-11-06.
//

import SwiftUI
import MapKit

struct AddLocationView: View {
    @StateObject private var viewModel = LocationViewModel()
    
    var body: some View {
        VStack() {
            TextField("Level", text: $viewModel.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .bold()
                .padding([.top, .leading, .trailing])
            
            TextField("Address", text: $viewModel.address)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .bold()
                .padding(.horizontal)
                .onChange(of: viewModel.address) {
                    viewModel.updateSearchResults(for: viewModel.address)
                }
            
            if !viewModel.autocompleteResults.isEmpty {
                List(viewModel.autocompleteResults, id: \.self) { result in
                    Text(result)
                        .onTapGesture {
                            viewModel.isSelected = true
                            viewModel.address = result
                            viewModel.autocompleteResults = []
                        }
                }
                .frame(maxHeight: 200)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .listStyle(.plain)
            }
            
            
            Button(action: {
                viewModel.isSelected = true
                viewModel.saveLocation()
                viewModel.fetchLocation()
            }) {
                Text("Save Location")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
            if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
                    .padding()
                
            }
            
            List {
                ForEach(viewModel.locations, id: \.id) { location in
                    VStack(alignment: .leading) {
                        Text(location.name)
                            .font(.headline)
                        Text("Address: \(location.address)")
                            .font(.subheadline)
                    }
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .listStyle(.plain)

        }
        .padding()
    }
}

#Preview {
    AddLocationView()
}
