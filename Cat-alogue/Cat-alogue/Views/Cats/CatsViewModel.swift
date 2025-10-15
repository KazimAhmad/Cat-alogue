//
//  CatsViewModel.swift
//  Cat-alogue
//
//  Created by Kazim Ahmad on 15/10/2025.
//

import Foundation
import SwiftUI

@MainActor
class CatsViewModel: ObservableObject {
    //MARK: for scaling purposes we can use the path with coordinator and routes to have centerlised controlling
    @Published var path = NavigationPath()
    
    @Published var cats: [Cat] = []
    @Published var filteredCats: [Cat] = []

    @Published var breeds: [Breed] = []
    @Published var viewState: ViewState = .loading
    
    @Published var isBreedsExpanded: Bool = false
    @Published var selectedBreed: Breed?
    
    init() {
        loadCats()
        getBreeds()
    }
    
    func showBreeds() -> Bool {
        return breeds.count > 0
    }
    
    func didSelect(breed: Breed) {
        selectedBreed = breed
        viewState = .loading
        filterCat()
    }
    
    func didCancelSelection() {
        selectedBreed = nil
        filteredCats.removeAll()
        viewState = .info
    }
    
    func loadCats() {
        Task {
            do {
                let cats = try await Cat.get(limit: 40)
                self.cats = cats
                print(cats)
                viewState = .info
            } catch {
                viewState = .error(error)
            }
        }
    }
    
    func filterCat() {
        Task {
            do {
                let cats = try await Cat.get(limit: 40,
                                             breed: selectedBreed)
                self.filteredCats = cats
                viewState = .info
            } catch {
                viewState = .error(error)
            }
        }
    }
    
    func getBreeds() {
        Task {
            do {
                let breeds = try await Breed.get()
                self.breeds = breeds
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
