//
//  CatView.swift
//  Cat-alogue
//
//  Created by Kazim Ahmad on 15/10/2025.
//

import SwiftUI

struct CatView: View {
    var cat: Cat
    var addFavorite: (Cat) -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.accentColor.opacity(0.8))
                .frame(height: 300)
            VStack {
                if let imageURL = URL(string: cat.url) {
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .frame(height: 200)
                    } placeholder: {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .tint(.primary)
                            .frame(height: 200)
                    }
                    Text(cat.id)
                    Text(cat.breeds.first?.name ?? "No breed")
                    Button {
                        addFavorite(cat)
                    } label: {
                        Image(systemName: cat.isFavorite ? "heart.fill" : "heart")
                            .foregroundStyle(Color.white)
                            .frame(width: 32, height: 32)
                    }
                }
                Spacer()
            }
        }
        .padding(.bottom, 4)
    }
}
