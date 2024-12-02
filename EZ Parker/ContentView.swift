//
//  ContentView.swift
//  EZ Parker
//
//  Created by Minh Duc Pham on 2024-11-06.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationStack {
                AddParkingView()
                    .navigationTitle("Parking")
            }
            .tabItem {
                Label("Parking", systemImage: "parkingsign.square")
            }
            NavigationStack {
                AddLocationView()
                    .navigationTitle("Location")
            }
            .tabItem {
                Label("Locations", systemImage: "map")
            }
            NavigationStack {
                AddVehicleView()
                    .navigationTitle("Vehicle")
            }
            .tabItem {
                Label("Vehicle", systemImage: "car")
            }
        }
    }
}

#Preview {
    ContentView()
}
