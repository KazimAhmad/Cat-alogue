//
//  DataManager.swift
//  Cat-alogue
//
//  Created by Kazim Ahmad on 15/10/2025.
//

import CoreData
import Foundation

class CoreDataManager: NSObject, ObservableObject {
    
    static let shared = CoreDataManager()
    
    @Published var cats: [Cat] = []
            
    fileprivate var managedObjectContext: NSManagedObjectContext
    private let catsFRC: NSFetchedResultsController<CatCD>
    
    private override init() {
        let persistentStore = PersistenceController.shared
        self.managedObjectContext = persistentStore.container.viewContext

        let catsFR: NSFetchRequest<CatCD> = CatCD.fetchRequest()
        catsFR.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        self.catsFRC = NSFetchedResultsController(fetchRequest: catsFR,
                                               managedObjectContext: managedObjectContext,
                                               sectionNameKeyPath: nil,
                                               cacheName: nil)
        super.init()
        
        // Initial fetch to populate todos array
        catsFRC.delegate = self
        try? catsFRC.performFetch()
        if let newCats = catsFRC.fetchedObjects {
            self.cats = newCats.map({ catCD in
                return Cat(id: catCD.id ?? "",
                           width: 200,
                           height: 200,
                           url: catCD.url ?? "",
                           breeds: [Breed.init(weight: Weight(imperial: "", metric: ""),
                                               id: catCD.breed ?? "",
                                               name: catCD.breed ?? "",
                                               temperament: "",
                                               origin: "",
                                               countryCodes: nil, countryCode: nil, lifeSpan: nil, wikipediaURL: nil)],
                           isFavorite: catCD.is_fav)
            })
        }
    }
    
    func saveData() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                NSLog("Unresolved error saving context: \(error), \(error.userInfo)")
            }
        }
    }
}

extension CoreDataManager: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if let newCats = controller.fetchedObjects as? [CatCD] {
            self.cats = newCats.map({ catCD in
                return Cat(id: catCD.id ?? "",
                           width: 200,
                           height: 200,
                           url: catCD.url ?? "",
                           breeds: [Breed.init(weight: Weight(imperial: "", metric: ""),
                                               id: catCD.breed ?? "",
                                               name: catCD.breed ?? "",
                                               temperament: "",
                                               origin: "",
                                               countryCodes: nil, countryCode: nil, lifeSpan: nil, wikipediaURL: nil)],
                           isFavorite: catCD.is_fav)
            })
        }
    }
    
    func fetchCats(predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) -> [Cat] {
        if let predicate = predicate {
            catsFRC.fetchRequest.predicate = predicate
        }
        if let sortDescriptors = sortDescriptors {
            catsFRC.fetchRequest.sortDescriptors = sortDescriptors
        }
        try? catsFRC.performFetch()
        if let newCats = catsFRC.fetchedObjects {
            return newCats.map({ catCD in
                return Cat(id: catCD.id ?? "",
                           width: 200,
                           height: 200,
                           url: catCD.url ?? "",
                           breeds: [Breed.init(weight: Weight(imperial: "", metric: ""),
                                               id: catCD.breed ?? "",
                                               name: catCD.breed ?? "",
                                               temperament: "",
                                               origin: "",
                                               countryCodes: nil, countryCode: nil, lifeSpan: nil, wikipediaURL: nil)],
                           isFavorite: catCD.is_fav)
            })
        } else {
            return []
        }
    }
    
    private func fetchFirst<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate?) -> Result<T?, Error> {
        let request = objectType.fetchRequest()
        request.predicate = predicate
        request.fetchLimit = 1
        do {
            let result = try managedObjectContext.fetch(request) as? [T]
            return .success(result?.first)
        } catch {
            return .failure(error)
        }
    }
    
    func updateAndSave(cat: Cat) {
        let predicate = NSPredicate(format: "id = %@", cat.id as CVarArg)
        let result = fetchFirst(CatCD.self, predicate: predicate)
        switch result {
        case .success(let managedObject):
            if let catCD = managedObject {
                update(catCD: catCD, from: cat)
            } else {
                newCatCD(from: cat)
            }
        case .failure(_):
            print("Couldn't fetch TodoMO to save")
        }
        
        saveData()
    }
    
    private func newCatCD(from cat: Cat) {
        let catCD = CatCD(context: managedObjectContext)
        catCD.id = cat.id
        update(catCD: catCD, from: cat)
    }
    
    private func update(catCD: CatCD, from cat: Cat) {
        catCD.id = cat.id
        catCD.breed = cat.breeds.first?.name ?? "No Breed"
        catCD.url = cat.url
        catCD.is_fav = cat.isFavorite
    }

    
    func delete(cat: Cat) {
        let predicate = NSPredicate(format: "id = %@", cat.id as CVarArg)
        let result = fetchFirst(CatCD.self, predicate: predicate)
        switch result {
        case .success(let managedObject):
            if let catCd = managedObject {
                managedObjectContext.delete(catCd)
            }
        case .failure(_):
            print("Couldn't fetch TodoMO to save")
        }
        saveData()
    }
}
