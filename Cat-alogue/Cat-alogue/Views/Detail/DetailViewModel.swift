//
//  DetailViewModel.swift
//  Cat-alogue
//
//  Created by Kazim Ahmad on 15/10/2025.
//

import Combine
import Foundation
import SwiftUI

@MainActor
class DetailViewModel: ObservableObject {
    @Published var cat: Cat
    @Published private var dataManager: CoreDataManager
    var anyCancellable: AnyCancellable? = nil

    init(cat: Cat) {
        self.cat = cat
        self.dataManager = CoreDataManager.shared
        anyCancellable = dataManager.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        }
    }
    
    func addFav() {
        self.cat.isFavorite.toggle()
    }
}
