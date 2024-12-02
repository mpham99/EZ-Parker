//
//  AddVehicleView.swift
//  EZ Parker
//
//  Created by Minh Duc Pham on 2024-11-28.
//

import SwiftUI

struct AddVehicleView: View {
    @StateObject private var viewModel = VehicleViewModel()
    
    var body: some View {
        VStack() {
            TextField("Vehicle Name", text: $viewModel.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .bold()
                .padding([.top, .leading, .trailing])
            
            Button(action: {
                viewModel.saveVehicle()
                viewModel.fetchVehicle()
            }) {
                Text("Save Vehicle")
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
                ForEach(viewModel.vehicles, id: \.id) { vehicle in
                    VStack(alignment: .leading) {
                        Text(vehicle.name)
                            .font(.headline)
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
