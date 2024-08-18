//
//  RandomComicCell .swift
//  MarvelVerse
//
//  Created by Mateusz Krówczyński on 13/08/2024.
//

import SwiftUI

struct RandomComicForTheDayCell: View {
    
    var imageName: String = Constants.mockImage
    var comic: Comic = .mock
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            ZStack {
                ImageLoader(imageURL: imageName)
                    .frame(width: 360, height: 280)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(8)
                    .shadow(color: .secondary, radius: 5, x: 0, y: 10)
                VStack(alignment: .leading, spacing: 8) {
                    Text(comic.title?.uppercased() ?? "")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.marvelWhite)
                    
                    Text(comic.series?.name?.uppercased() ?? "")
                        .font(.caption)
                        .foregroundStyle(.marvelWhite.opacity(0.8))
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                }
                .padding(.bottom, 10)
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
            }
        }
    }
}

#Preview {
    ZStack {
        Color.marvelWhite.ignoresSafeArea()
        RandomComicForTheDayCell()
    }
}
