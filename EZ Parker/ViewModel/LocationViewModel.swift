//
//  LocationViewModel.swift
//  EZ Parker
//
//  Created by Minh Duc Pham on 2024-11-06.
//

import FirebaseFirestore

class LocationViewModel: ObservableObject {
    @Published var address: String = ""
    @Published var name: String = ""
    @Published var errorMessage: String = ""
    @Published var locations: [Location] = []
    
    private let db = Firestore.firestore()
    
    init() {
        fetchLocation()
    }
    
    func saveLocation() {
        let newLocation = Location(address: address, name: name)
        
        do {
            _ = try db.collection("locations").addDocument(from: newLocation) { error in
                if let error = error {
                    self.errorMessage = "Error saving location: \(error.localizedDescription)"
                } else {
                    self.clearInputs()
                }
            }
        } catch {
            self.errorMessage = "Failed to encode location: \(error.localizedDescription)"
        }
    }
    
    func fetchLocation() {
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
        }
    }
    
    private func clearInputs() {
        self.address = ""
        self.name = ""
        self.errorMessage = ""
    }
}
