//
//  HeaderView.swift
//  MarvelVerse
//
//  Created by Mateusz Krówczyński on 09/08/2024.
//

import SwiftUI

struct HeaderView: View {
    
    private let marvelLogoImage: String = "marvel_logo"
    
    var body: some View {
        VStack() {
            Image(marvelLogoImage)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .padding(.bottom)
        .frame(height: 70)
        .background(Color.marvelRed.ignoresSafeArea())
    }
}

#Preview {
    HeaderView()
}
