//
//  RandomCharacterForTheDayView.swift
//  MarvelVerse
//
//  Created by Mateusz Krówczyński on 15/08/2024.
//

import SwiftUI

struct RandomCharacterForTheDayView: View {
    @StateObject var viewModel: MarvelVerseViewModel = MarvelVerseViewModel()
    
    var body: some View {
        ZStack {
            VStack() {
                HStack {
                    VStack(spacing: 12) {
                        Text("Character Of The Day")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(.marvelRed)
                        
                        ForEach(viewModel.randomCharacter) { randomCharacter in
                            if viewModel.isLoadingCharacter {
                                ProgressView()
                            } else {
                                RandomCharacterCell(imageName: viewModel.extractImage(data: randomCharacter.thumbnail ?? ["":""]), character: randomCharacter)
                            }
                        }
                    }
                }
            }
        }
        .task {
            await viewModel.getRandomCharacterData()
        }
    }
}

#Preview {
    RandomCharacterForTheDayView()
}
