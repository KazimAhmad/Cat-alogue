//
//  DetailView.swift
//  Cat-alogue
//
//  Created by Kazim Ahmad on 15/10/2025.
//

import SwiftUI

struct DetailView: View {
    @StateObject var viewModel: DetailViewModel
    
    var body: some View {
        GeometryReader { gr in
            ScrollView {
                VStack(alignment: .leading) {
                    if let imageURL = URL(string: viewModel.cat.url) {
                        AsyncImage(url: imageURL) { image in
                            image
                                .resizable()
                                .frame(width: gr.size.width - 16,
                                       height: gr.size.width,
                                       alignment: .leading)
                        } placeholder: {
                            ProgressView()
                                .progressViewStyle(.circular)
                                .tint(.accentColor)
                                .frame(width: gr.size.width,
                                       height: gr.size.width,
                                       alignment: .leading)
                        }
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            Text(viewModel.cat.id)
                            Text(viewModel.cat.breeds.first?.name ?? "No Breeds")
                        }
                        .foregroundStyle(Color.primary)
                        .font(.headline)
                        .fontWeight(.semibold)
                        Spacer()
                        Button {
                            viewModel.addFav()
                        } label: {
                            Image(systemName: viewModel.cat.isFavorite ? "heart.fill" : "heart")
                                .foregroundStyle(Color.accentColor)
                                .frame(width: 40, height: 40)
                        }
                    }
                }
                .padding(8)
            }
        }
    }
}

#Preview {
    DetailView(viewModel: DetailViewModel(cat: Cat(id: "123",
                                                   width: 0,
                                                   height: 0,
                                                   url: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg",
                                                   breeds: [],
                                                   isFavorite: true)))
}
