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
                AddLocationView()
                    .navigationTitle("Location")
            }
            .tabItem {
                Label("Locations", systemImage: "map")
            }
        }
    }
}

#Preview {
    ContentView()
}
