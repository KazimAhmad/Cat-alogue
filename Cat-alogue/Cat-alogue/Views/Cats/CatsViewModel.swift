//
//  CatsViewModel.swift
//  Cat-alogue
//
//  Created by Kazim Ahmad on 15/10/2025.
//

import Combine
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
    
    @Published private var dataManager: CoreDataManager
    var anyCancellable: AnyCancellable? = nil

    init() {
        self.dataManager = CoreDataManager.shared
        anyCancellable = dataManager.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        }
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
        let catsFromCD = dataManager.cats
        if catsFromCD.count > 0 {
            cats = catsFromCD
            viewState = .info
            return
        }
        Task {
            do {
                let cats = try await Cat.get(limit: 40)
                self.cats = cats
                viewState = .info
                for cat in cats {
                    dataManager.updateAndSave(cat: cat)
                }
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
