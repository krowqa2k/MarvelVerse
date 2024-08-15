//
//  ComicCellView.swift
//  MarvelVerse
//
//  Created by Mateusz Krówczyński on 14/08/2024.
//

import SwiftUI

struct ComicCellView: View {
    
    var imageName: String? = Constants.mockImage
    var comic: Comic = .mock
    
    var body: some View {
        ZStack(alignment: .top){
            VStack(alignment: .leading, spacing: 8) {
                ImageLoader(imageURL: imageName ?? Constants.noImage)
                    .frame(width: 120, height: 180)
                    .cornerRadius(4)
                
                Text(comic.title ?? "")
                    .font(.system(size: 11))
                    .fontWeight(.semibold)
                    .foregroundStyle(.marvelBlack)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
            }
            .frame(maxWidth: 120)
        }
    }
}


#Preview {
    ComicCellView()
}
