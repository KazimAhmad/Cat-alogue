//
//  Cat.swift
//  Cat-alogue
//
//  Created by Kazim Ahmad on 15/10/2025.
//

import Foundation
// MARK: - Cat
struct Cat: Codable {
    let id: String
    let width, height: Int
    let url: String
    let breeds: [Breed]
    
    //MARK: now using the object and async await i am using the object to play around with the CRUD from the API
    //so then i can use the object itself to access the method wherever i want in the app like:

    static func get(limit: Int = 10,
                    breed: Breed? = nil) async throws -> [Self] {
        var query: [String: Any] = ["limit": limit,
                                    "include_breeds": true,
                                    "include_categories": true]
        if let breed = breed {
            query["breed_ids"] = breed.id
        }
        return try await Services.shared.request(Endpoints.images.path,
                                                 query: query)
    }
    
    /* and the same way to all of the operations on the object like
    func update() async throws -> Self {}
    func delete() async throws -> Self {}
    func create() async throws -> Self {}
     
     and then in the app where i have an object i can use like:
     let cat: Cat?
     
     func catFromAPI() {
        cat = Cat()
     }
     
     func updateCat() {
        cat.valueToUpdate = updatedValue
        cat.update()
     }
    */
}
