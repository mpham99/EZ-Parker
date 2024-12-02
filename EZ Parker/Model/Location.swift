//
//  Location.swift
//  EZ Parker
//
//  Created by Minh Duc Pham on 2024-11-06.
//

import Foundation
import FirebaseFirestore

struct Location: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var address: String
    var name: String
    
    init(id: String? = nil, address: String, name: String) {
        self.id = id
        self.address = address
        self.name = name
    }
                      
    public var description: String { return "\(name) - \(address)" }

}
