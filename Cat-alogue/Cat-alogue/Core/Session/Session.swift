//
//  Session.swift
//  Cat-alogue
//
//  Created by Kazim Ahmad on 15/10/2025.
//

import Foundation

class Session: ObserverObject {
    static let current = Session()
 
    @Published private(set) var isSkipped: Bool = false

    override init() {
        super.init()
        
        observe(Services.shared.$isAuthSkipped) { [weak self] skipped in
            self?.isSkipped = skipped != nil
        }
    }
}
