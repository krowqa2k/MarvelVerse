//
//  RandomComicCell .swift
//  MarvelVerse
//
//  Created by Mateusz Krówczyński on 13/08/2024.
//

import SwiftUI

struct RandomComicForTheDayCell: View {
    
    var imageName: String = Constants.mockImage
    var comic: RandomComicModel = .mock
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            ZStack {
                ImageLoader(imageURL: imageName)
                    .frame(width: 360, height: 280)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(8)
                VStack(alignment: .leading, spacing: 8) {
                    Text(comic.title?.uppercased() ?? "")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.marvelWhite)
                    
                    Text(comic.series?.name?.uppercased() ?? "")
                        .font(.caption)
                        .foregroundStyle(.marvelWhite.opacity(0.6))
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                }
                .padding(.bottom, 30)
                .padding(.horizontal)
                .frame(maxWidth: 360, alignment: .leading)
                .frame(maxHeight: 280, alignment: .bottom)
                .background(
                    LinearGradient(
                        colors: [Color.marvelBlack.opacity(0.01), Color.marvelBlack.opacity(0.5)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .cornerRadius(8)
                )
                .overlay (
                    Rectangle()
                        .fill(Color.marvelRed.opacity(0.8))
                        .frame(width: 80, height: 80, alignment: .bottom)
                        .clipShape(
                            UnevenRoundedRectangle(
                                bottomTrailingRadius: 8
                            )
                        )
                        .overlay {
                            Text("MORE DETAILS")
                                .fontWeight(.bold)
                                .foregroundStyle(.marvelWhite)
                        }
                        .onTapGesture {
                            
                        }
                    ,alignment: .bottomTrailing
                )
            }
            .shadow(color: .secondary, radius: 5, x: -1, y: 10)
        }
    }
}

#Preview {
    ZStack {
        Color.marvelWhite.ignoresSafeArea()
        RandomComicForTheDayCell()
    }
}
