//
//  Breed.swift
//  Cat-alogue
//
//  Created by Kazim Ahmad on 15/10/2025.
//

import Foundation
// MARK: - Breed
struct Breed: Codable {
    let weight: Weight
    let id, name, temperament, origin: String
    let countryCodes, countryCode, lifeSpan: String?
    let wikipediaURL: String?

    enum CodingKeys: String, CodingKey {
        case weight, id, name, temperament, origin
        case countryCodes = "country_codes"
        case countryCode = "country_code"
        case lifeSpan = "life_span"
        case wikipediaURL = "wikipedia_url"
    }
    
    static func get() async throws -> [Self] {
        return try await Services.shared.request(Endpoints.breeds.path)
    }
}

extension Breed: Identifiable, Hashable {
    public var identifier: String {
        self.id
    }
    
    public static func == (lhs: Breed, rhs: Breed) -> Bool {
        return lhs.id == rhs.id
    }
}
