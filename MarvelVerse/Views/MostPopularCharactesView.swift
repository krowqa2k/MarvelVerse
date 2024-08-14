//
//  MostPopularCharactesView.swift
//  MarvelVerse
//
//  Created by Mateusz Krówczyński on 14/08/2024.
//

import SwiftUI

struct MostPopularCharactesView: View {
    
    @StateObject var viewModel: MarvelVerseViewModel = MarvelVerseViewModel()
    
    var body: some View {
        ZStack {
            Color.marvelWhite
            if viewModel.isLoading {
                ProgressView()
            } else {
                ScrollView(.vertical){
                    LazyVStack(alignment: .leading, spacing: 16) {
                        Text("SPIDER-MAN")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.marvelBlack)
                        ScrollView(.horizontal) {
                            LazyHStack(spacing: 8) {
                                ForEach(viewModel.spiderManComics.shuffled()) { spiderMan in
                                    ComicCellView(imageName: viewModel.extractImage(data: spiderMan.thumbnail), comic: spiderMan)
                                        .frame(width: 120)
                                        .frame(maxHeight: 260)
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                        .padding(.trailing)
                    }
                    .padding(.leading)
                }
            }
        }
        .task {
            await viewModel.getSpiderManComicData()
        }
    }
}


#Preview {
    MostPopularCharactesView()
}
