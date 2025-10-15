//
//  Cat_alogueApp.swift
//  Cat-alogue
//
//  Created by Kazim Ahmad on 14/10/2025.
//

import SwiftUI

@main
struct Cat_alogueApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

struct MainView: View {
    @ObservedObject private var session = Session.current
    
    var body: some View {
        if session.isSkipped {
            CatsView(viewModel: CatsViewModel())
        } else {
            OnboardingView(viewModel: OnboardingViewModel())
        }
    }
}
