//
//  LocationViewModel.swift
//  EZ Parker
//
//  Created by Minh Duc Pham on 2024-11-06.
//

import FirebaseFirestore
import Combine
import Foundation
import MapKit

class LocationViewModel: NSObject, ObservableObject {
    @Published var address: String = ""
    @Published var name: String = ""
    @Published var errorMessage: String = ""
    @Published var locations: [Location] = []
    @Published var autocompleteResults: [String] = []
    
    private let db = Firestore.firestore()
    private var searchCompleter = MKLocalSearchCompleter()
    private var cancellables = Set<AnyCancellable>()
    var isSelected = false
    
    override init() {
        super.init()
        fetchLocation()
        searchCompleter.delegate = self
        searchCompleter.resultTypes = .address
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
    
    func updateSearchResults(for query: String) {
        if !isSelected {
            searchCompleter.queryFragment = query
        } else {
            isSelected = false
        }
    }
    
    private func clearInputs() {
        self.address = ""
        self.name = ""
        self.errorMessage = ""
    }
}

extension LocationViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.autocompleteResults = completer.results.map { $0.title }
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        self.errorMessage = "Error fetching autocomplete results: \(error.localizedDescription)"
    }
}
