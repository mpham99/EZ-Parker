//
//  AddLocationView.swift
//  EZ Parker
//
//  Created by Minh Duc Pham on 2024-11-06.
//

import SwiftUI

import SwiftUI

struct AddLocationView: View {
    @StateObject private var viewModel = LocationViewModel()
    
    var body: some View {
        VStack() {
            TextField("Name", text: $viewModel.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .bold()
                .padding([.top, .leading, .trailing])
            
            TextField("Address", text: $viewModel.address)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .bold()
                .padding(.horizontal)
            
            
            Button(action: {
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

        }
        .padding()
    }
}

#Preview {
    AddLocationView()
}
