//
//  RandomCharacterCell.swift
//  MarvelVerse
//
//  Created by Mateusz Krówczyński on 15/08/2024.
//

import SwiftUI

struct RandomCharacterCell: View {
    var imageName: String = Constants.mockImage
    var character: RandomCharacterModel = .mock
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            ZStack {
                ImageLoader(imageURL: imageName)
                    .frame(width: 220, height: 280)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(8)
                    .shadow(color: .secondary, radius: 5, x: 0, y: 10)
                VStack(alignment: .leading, spacing: 8) {
                    Text(character.name?.uppercased() ?? "")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.marvelWhite)
                        .padding(.bottom)
                }
                .padding(.bottom, 10)
                .padding(.horizontal)
                .frame(maxWidth: 220, alignment: .leading)
                .frame(maxHeight: 280, alignment: .bottom)
                .background(
                    LinearGradient(
                        colors: [Color.marvelBlack.opacity(0.01), Color.marvelBlack.opacity(0.5)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .cornerRadius(8)
                )
            }
        }
    }
}

#Preview {
    RandomCharacterCell()
}
