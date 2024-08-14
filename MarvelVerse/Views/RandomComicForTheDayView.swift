//
//  RandomComicView.swift
//  MarvelVerse
//
//  Created by Mateusz Krówczyński on 13/08/2024.
//

import SwiftUI

struct RandomComicForTheDayView: View {
    
    @StateObject var viewModel: MarvelVerseViewModel = MarvelVerseViewModel()
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                VStack() {
                    HStack {
                        VStack(spacing: 12) {
                            Text("Random Comic For The Day")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundStyle(.marvelBlack)
                            
                            ForEach(viewModel.randomComic) { randomComic in
                                RandomComicForTheDayCell(imageName: viewModel.extractImage(data: randomComic.thumbnail ?? ["":""]), comic: randomComic)
                            }
                        }
                    }
                }
            }
        }
        .task {
            await viewModel.getRandomComicData()
        }
    }
}

#Preview {
    RandomComicForTheDayView()
}
