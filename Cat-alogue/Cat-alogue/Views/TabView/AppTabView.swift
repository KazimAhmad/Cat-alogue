//
//  TabView.swift
//  Cat-alogue
//
//  Created by Kazim Ahmad on 15/10/2025.
//

import SwiftUI

struct AppTabView: View {
    @State private var selectedTabIndex = 0
    
    var body: some View {
        TabView(selection: $selectedTabIndex) {
            Tab("Cats",
                systemImage: "cat.fill",
                value: 0) {
                CatsView(viewModel: CatsViewModel())
            }
            Tab("Fav", systemImage: "heart.fill",
                value: 1) {
                FavView(viewModel: FavViewModel())
            }
        }
    }
}

#Preview {
    AppTabView()
}
