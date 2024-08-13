//
//  RandomComicView.swift
//  MarvelVerse
//
//  Created by Mateusz Krówczyński on 13/08/2024.
//

import SwiftUI

struct RandomComicView: View {
    
    @StateObject var viewModel: MarvelVerseViewModel = MarvelVerseViewModel()
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            }
        }
        List(viewModel.randomComic) { randomComic in
            Text(randomComic.title ?? "")
                .foregroundStyle(.marvelBlack)
        }
        .task {
            await viewModel.getRandomComicData()
        }
    }
}

#Preview {
    RandomComicView()
}
