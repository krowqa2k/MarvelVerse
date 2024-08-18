//
//  SearchView.swift
//  MarvelVerse
//
//  Created by Mateusz Krówczyński on 16/08/2024.
//

import SwiftUI

struct SearchView: View {

    @State private var query: String = ""
    @StateObject private var viewModel: MarvelVerseViewModel = MarvelVerseViewModel()
    
    var body: some View {
        ZStack {
            Color.marvelWhite.ignoresSafeArea()
            VStack(spacing: 8){
                searchBar
                if viewModel.isLoadingSearch {
                    ProgressView()
                        .tint(.marvelRed)
                        .background(
                            UnevenRoundedRectangle(
                                topLeadingRadius: 8,
                                topTrailingRadius: 8
                            )
                            .foregroundStyle(.marvelWhite)
                        )
                        .offset(y: -10)
                } else {
                    comicsList
                }
                Spacer()
            }
        }
    }
    
    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .font(.title)
                .foregroundStyle(.marvelRed)
                .padding(.leading)
                .padding(.trailing, 0)
            TextField("Search Movies, TV Series...", text: $query) {
                Task {
                    viewModel.getSearchDBData(query:query)
                }
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.trailing,12)
            .padding(.leading, 0)
            .frame(maxWidth: .infinity)
            .tint(.marvelWhite)
            
            if !query.isEmpty {
                Image(systemName: "xmark.circle.fill")
                    .padding(.trailing,24)
                    .background(Color.marvelBlack.opacity(0.01))
                    .foregroundStyle(.marvelBlack)
                    .onTapGesture {
                        query = ""
                        Task {
                            viewModel.getSearchDBData(query:query)
                        }
                    }
            }
        }
        .padding(.top)
        .background(
            UnevenRoundedRectangle(
                topLeadingRadius: 8,
                topTrailingRadius: 8
            )
            .fill(.marvelWhite)
        )
        .offset(y: -10)
    }
    
    private var comicsList: some View {
        ScrollView(.vertical){
            if viewModel.isEmpty{
                ContentUnavailableView("No comics found :(", systemImage: "book.and.wrench", description: Text("Try to search for comics with different title!"))
                    .frame(maxWidth: .infinity)
                    .frame(height: UIScreen.main.bounds.height / 2)
                    .foregroundStyle(.marvelBlack)
            }
            ForEach(viewModel.comicSearch){ comic in
                NavigationLink(destination: DetailsView(imageName: viewModel.extractImage(data: comic.thumbnail), comic: comic)) {
                    ComicCellView(imageName: viewModel.extractImage(data: comic.thumbnail), comic: comic)
                }
            }
        }
    }
}

#Preview {
    SearchView()
}
