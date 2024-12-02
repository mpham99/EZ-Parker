//
//  Parking.swift
//  EZ Parker
//
//  Created by Minh Duc Pham on 2024-12-01.
//

import Foundation

struct Parking: Identifiable {
    let id = UUID()
    let location: Location
    let vehicle: Vehicle
    let timestamp: Date
}
