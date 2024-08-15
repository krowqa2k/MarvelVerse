//
//  MainView.swift
//  MarvelVerse
//
//  Created by Mateusz Krówczyński on 09/08/2024.
//

import SwiftUI

struct MainView: View {
    
    private let marvelMainImage: String = "marvel_main"

    var body: some View {
        ZStack {
            Color.marvelWhite.ignoresSafeArea()
            VStack(spacing: 0) {
                HeaderView()
                
                mainViewImage
                
                Spacer()
            }
        }
    }
    
    private var mainViewImage: some View {
        VStack {
            RandomComicForTheDayView()
                .padding(.top, -40)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 370)
        .background(Color.marvelWhite)
        .clipShape(
            UnevenRoundedRectangle(
                topLeadingRadius: 6,
                topTrailingRadius: 6
            )
        )
        .offset(y: -15)
    }
}

#Preview {
    MainView()
}
