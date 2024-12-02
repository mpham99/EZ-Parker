//
//  ParkingViewModel.swift
//  EZ Parker
//
//  Created by Minh Duc Pham on 2024-12-01.
//

import Foundation
import SwiftUI
import FirebaseFirestore

class ParkingViewModel: ObservableObject {
    @Published var locations: [Location] = []
       @Published var vehicles: [Vehicle] = []
       @Published var selectedLocation: Location?
       @Published var selectedVehicle: Vehicle?
       @Published var parkingRecords: [Parking] = []
       @Published var errorMessage: String = ""
       @Published var isLoading: Bool = true

       private let db = Firestore.firestore()

       func fetchSavedData() {
           isLoading = true
           let group = DispatchGroup()

           group.enter()
           fetchLocations {
               group.leave()
           }

           group.enter()
           fetchVehicles {
               group.leave()
           }

           group.notify(queue: .main) {
               self.isLoading = false
           }
       }

       func saveParkingRecord() {
           guard let location = selectedLocation else {
               errorMessage = "Please select a location."
               return
           }
           guard let vehicle = selectedVehicle else {
               errorMessage = "Please select a vehicle."
               return
           }
           errorMessage = ""
           let newRecord = Parking(location: location, vehicle: vehicle, timestamp: Date())
           parkingRecords.append(newRecord)
       }

       private func fetchLocations(completion: @escaping () -> Void) {
           db.collection("locations").getDocuments { snapshot, error in
               if let error = error {
                   self.errorMessage = "Error fetching locations: \(error.localizedDescription)"
               } else {
                   if let snapshot = snapshot {
                       self.locations = snapshot.documents.compactMap { document in
                           try? document.data(as: Location.self)
                       }
                   }
               }
               DispatchQueue.main.async {
                   completion()
               }
           }
       }

       private func fetchVehicles(completion: @escaping () -> Void) {
           db.collection("vehicle").getDocuments { snapshot, error in
               if let error = error {
                   self.errorMessage = "Error fetching vehicle: \(error.localizedDescription)"
               } else {
                   if let snapshot = snapshot {
                       self.vehicles = snapshot.documents.compactMap { document in
                           try? document.data(as: Vehicle.self)
                       }
                   }
               }
               DispatchQueue.main.async {
                   completion()
               }
           }
       }
    
}
