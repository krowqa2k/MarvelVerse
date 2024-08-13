//
//  RandomComicCell .swift
//  MarvelVerse
//
//  Created by Mateusz Krówczyński on 13/08/2024.
//

import SwiftUI

struct RandomComicCell: View {
    
    var imageName: String = Constants.mockImage
    var comic: RandomComicModel = .mock
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            ImageLoader(imageURL: imageName)
                .frame(width: 120, height: 180)
                .aspectRatio(contentMode: .fill)
                .cornerRadius(4)
            
            Text(comic.title ?? "")
                .font(.system(size: 10))
                .fontWeight(.medium)
                .foregroundStyle(.marvelBlack)
            
            Text(comic.series?.name ?? "")
                .font(.system(size: 9))
                .foregroundStyle(.secondary)
        }
        .multilineTextAlignment(.leading)
        .lineLimit(4)
        .frame(maxWidth: 120)
    }
}

#Preview {
    ZStack {
        Color.marvelWhite.ignoresSafeArea()
        RandomComicCell()
    }
}
