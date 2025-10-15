//
//  FavViewModel.swift
//  Cat-alogue
//
//  Created by Kazim Ahmad on 15/10/2025.
//
import Combine
import Foundation
import SwiftUI

@MainActor
class FavViewModel: ObservableObject {
    @Published var path = NavigationPath()
    @Published var cats: [Cat] = []
    @Published var viewState: ViewState = .loading

    @Published private var dataManager: CoreDataManager
    var anyCancellable: AnyCancellable? = nil

    init() {
        self.dataManager = CoreDataManager.shared
        anyCancellable = dataManager.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        }
    }
    
    func addFav(for cat: Cat) {
        if let index = cats.firstIndex(where: { $0.id == cat.id }) {
            cats[index].isFavorite.toggle()
            dataManager.updateAndSave(cat: cats[index])
            cats.remove(at: index)
        }
    }

    func loadCats() {
        let catsFromCD = dataManager.fetchCats(predicate: NSPredicate(format: "is_fav == YES"))
        if catsFromCD.count > 0 {
            cats = catsFromCD
        }
        viewState = .info
    }
}
