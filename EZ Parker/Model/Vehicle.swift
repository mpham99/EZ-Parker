//
//  Vehicle.swift
//  EZ Parker
//
//  Created by Minh Duc Pham on 2024-11-28.
//

import Foundation
import FirebaseFirestore

struct Vehicle: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var name: String
    
    init(id: String? = nil, name: String) {
        self.id = id
        self.name = name
    }
}
