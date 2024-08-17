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
            HStack(alignment: .top, spacing: 4) {
                ImageLoader(imageURL: imageName ?? Constants.noImage)
                    .frame(width: 120, height: 180)
                    .cornerRadius(4)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(comic.title ?? "")
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .foregroundStyle(.marvelBlack)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 2)
                    
                    Text(comic.description ?? "")
                        .font(.system(size: 10))
                        .foregroundStyle(.marvelBlack.opacity(0.6))
                        .multilineTextAlignment(.leading)
                }
                .frame(maxWidth: 240)
                .frame(maxHeight: 180, alignment: .top)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        }
    }
}


#Preview {
    ComicCellView()
}
