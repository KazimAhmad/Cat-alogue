//
//  Weight.swift
//  Cat-alogue
//
//  Created by Kazim Ahmad on 15/10/2025.
//

import Foundation
// MARK: - Weight
struct Weight: Codable {
    let imperial, metric: String
    var id = UUID().uuidString
    
    enum CodingKeys: CodingKey {
        case imperial
        case metric
    }
    
    init(imperial: String, metric: String) {
        self.imperial = imperial
        self.metric = metric
        self.id = UUID().uuidString
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imperial = try container.decode(String.self, forKey: .imperial)
        self.metric = try container.decode(String.self, forKey: .metric)
        self.id = UUID().uuidString
    }
}

extension Weight: Identifiable, Hashable {    
    var identifier: String { imperial }
    public static func == (lhs: Weight, rhs: Weight) -> Bool {
        return lhs.id == rhs.id
    }
}
