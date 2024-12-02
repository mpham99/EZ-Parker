//
//  AddParkingView.swift
//  EZ Parker
//
//  Created by Minh Duc Pham on 2024-12-01.
//

import Foundation
import SwiftUI

struct AddParkingView: View {
    @StateObject private var viewModel = ParkingViewModel()

    var body: some View {
        VStack(spacing: 16) { // Adjust spacing between elements
            if viewModel.isLoading {
                ProgressView("Loading...")
                    .padding()
            } else {
                // Location Picker
                HStack(spacing: 8) {
                    Text("Location")
                        .font(.headline)
                    Spacer()
                    Picker("Select", selection: $viewModel.selectedLocation) {
                        ForEach(viewModel.locations, id: \.id) { location in
                            Text(location.name).tag(location as Location?)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }.padding(.horizontal)

                // Vehicle Picker
                HStack(spacing: 8) {
                    Text("Vehicle")
                        .font(.headline)
                    Spacer()
                    Picker("Select", selection: $viewModel.selectedVehicle) {
                        ForEach(viewModel.vehicles, id: \.id) { vehicle in
                            Text(vehicle.name).tag(vehicle as Vehicle?)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }.padding(.horizontal)

                // Save Button
                Button(action: {
                    viewModel.saveParkingRecord()
                }) {
                    Text("Save Parking")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal)

                // Error Message
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .padding(.horizontal)
                }

                // Parking Records List
                List(viewModel.parkingRecords) { record in
                    VStack(alignment: .leading) {
                        Text("Location: \(record.location.name)")
                        Text("Vehicle: \(record.vehicle.name)")
                        Text("Time: \(record.timestamp, formatter: dateFormatter)")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchSavedData()
        }
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
}
