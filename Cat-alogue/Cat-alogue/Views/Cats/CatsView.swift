//
//  CatsView.swift
//  Cat-alogue
//
//  Created by Kazim Ahmad on 15/10/2025.
//

import SwiftUI

struct CatsView: View {
    @StateObject var viewModel: CatsViewModel
        
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            ZStack {
                BackgroundView()
                VStack {
                    headerView()
                    switch viewModel.viewState {
                    case .loading:
                        LoadingView()
                    case .info:
                        ScrollView {
                            if viewModel.isBreedsExpanded {
                                breedsList()
                            }
                            if viewModel.selectedBreed == nil {
                                catList()
                            } else {
                                filteredCatList()
                            }
                        }
                        .refreshable {
                            //MARK: to delete all from core data and populate newly
                            viewModel.deleteAll()
                        }
                    case .error(let error):
                        Text(error.localizedDescription)
                    case .search:
                        Text("Search")
                    }
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
    }
    
    private func headerView() -> some View {
        HStack {
            Image(Constants.imageAppLogo)
                .resizable()
                .frame(width: 40, height: 40)
            VStack(alignment: .leading) {
                Text("Welcome to")
                    .font(.footnote)
                    .fontWeight(.medium)
                Text("Cat-alogue")
                    .foregroundStyle(Color.accentColor)
                    .font(.title3)
                    .fontWeight(.heavy)
            }
            Spacer()
            if viewModel.showBreeds() {
                Button {
                    viewModel.isBreedsExpanded.toggle()
                } label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(Color.primary)
                        .background(
                            RoundedRectangle(cornerRadius: 6.0)
                                .fill(Color.accentColor)
                                .frame(width: 40, height: 40)
                        )
                        .padding()
                }
            }
        }
    }
    
    private func breedsList() -> some View {
        VStack {
            HStack {
                Text("Breeds")
                    .font(.title2)
                    .foregroundStyle(Color.primary)
                    .fontWeight(.heavy)
                Spacer()
                Button {
                    
                } label: {
                    Text("See All")
                        .foregroundStyle(Color.accentColor)
                        .font(.footnote)
                        .fontWeight(.semibold)
                        
                }
            }
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.breeds.prefix(10), id: \.id) { breed in
                        Text(breed.name)
                            .foregroundStyle(Color.primary)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.accentColor.opacity(0.4))
                                    .frame(height: 40)
                            }
                            .onTapGesture {
                                viewModel.didSelect(breed: breed)
                            }
                    }
                }
            }
        }
        .padding(.vertical)
    }
    
    private func catList() -> some View {
        VStack {
            Text("Cats")
                .font(.title2)
                .foregroundStyle(Color.primary)
                .fontWeight(.heavy)
                .frame(maxWidth: .infinity, alignment: .leading)
            LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 200, maximum: 300)), count: 2)) {
                ForEach(viewModel.cats, id: \.id) { cat in
                    CatView(cat: cat) { catToAddFav in
                        viewModel.addFav(for: catToAddFav)
                    }
                }
            }
        }
    }
    
    private func filteredCatList() -> some View {
        VStack {
            HStack {
                Text("Cats in \(viewModel.selectedBreed?.name ?? "")")
                    .font(.title2)
                    .foregroundStyle(Color.primary)
                    .fontWeight(.heavy)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Button {
                    viewModel.didCancelSelection()
                } label: {
                    Image(systemName: "multiply")
                }
            }
            LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 200, maximum: 300)), count: 2)) {
                ForEach(viewModel.filteredCats, id: \.id) { cat in
                    CatView(cat: cat) { catToAddFav in
                        viewModel.addFav(for: catToAddFav)
                    }
                }
            }
        }
    }
}

#Preview {
    CatsView(viewModel: CatsViewModel())
}
