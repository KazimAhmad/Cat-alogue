//
//  FavView.swift
//  Cat-alogue
//
//  Created by Kazim Ahmad on 15/10/2025.
//

import SwiftUI

struct FavView: View {
    @StateObject var viewModel: FavViewModel

    var body: some View {
        NavigationStack(path: $viewModel.path) {
            ZStack {
                BackgroundView()
                VStack {
                    header()
                    ScrollView {
                        if viewModel.cats.isEmpty {
                            Text("No favorite cats yet")
                                .foregroundColor(.accentColor)
                                .font(.title2)
                                .fontWeight(.medium)
                                .padding(.vertical)
                        } else {
                            catList()
                        }
                    }
                }
                .padding(.horizontal)
            }
            .onAppear {
                viewModel.loadCats()
            }
        }
    }
    
    private func header() -> some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("Cat-alogue")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.accentColor)
                HStack {
                    Text("Welcome to your\nfavorite cats")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                        .padding()
                    Spacer()
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.accentColor)
                        .frame(width: .infinity)
                )
            }
            HStack {
                Spacer()
                Image(Constants.imageAppLogo)
                    .resizable()
                    .frame(width: 150, height: 150)
                    .offset(y: -32)

            }
            .padding()
        }
    }
    
    private func catList() -> some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 200, maximum: 300)), count: 2)) {
                ForEach(viewModel.cats, id: \.id) { cat in
                    CatView(cat: cat) { catToAddFav in
                        viewModel.addFav(for: catToAddFav)
                    }
                }
            }
        }
    }
}

#Preview {
    FavView(viewModel: FavViewModel())
}
