//
//  VehicleViewModel.swift
//  EZ Parker
//
//  Created by Minh Duc Pham on 2024-11-28.
//

import Foundation
import FirebaseFirestore

class VehicleViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var errorMessage: String = ""
    @Published var vehicles: [Vehicle] = []

    private let db = Firestore.firestore()
    var isSelected = false
    
    init() {
        fetchVehicle()
    }
    
    func saveVehicle() {
        let newVehicle = Vehicle(name: name)
        
        do {
            _ = try db.collection("vehicle").addDocument(from: newVehicle) { error in
                if let error = error {
                    self.errorMessage = "Error saving vehicle: \(error.localizedDescription)"
                } else {
                    self.clearInputs()
                }
            }
        } catch {
            self.errorMessage = "Failed to encode vehicle: \(error.localizedDescription)"
        }
    }
    
    func fetchVehicle() {
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
        }
    }
    
    private func clearInputs() {
        self.name = ""
        self.errorMessage = ""
    }
}
