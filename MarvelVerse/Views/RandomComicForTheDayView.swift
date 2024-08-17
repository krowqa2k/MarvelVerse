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
            VStack() {
                HStack {
                    VStack(spacing: 4) {
                        Text("Comic Of The Day")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(.marvelRed)
                        
                        ForEach(viewModel.randomComic) { randomComic in
                            if viewModel.isLoading {
                                ProgressView()
                            } else {
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
