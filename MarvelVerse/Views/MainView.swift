//
//  MainView.swift
//  MarvelVerse
//
//  Created by Mateusz Krówczyński on 09/08/2024.
//

import SwiftUI

struct MainView: View {
    
    @State private var screenIndex: Int = 0
    private let marvelMainImage: String = "marvel_main"

    var body: some View {
        ZStack {
            Color.marvelWhite.ignoresSafeArea()
            VStack(spacing: 0) {
                switch screenIndex{
                case 0:
                    HeaderView()
                    
                    mainViewImage
                    
                    RandomCharacterForTheDayView()
                        .offset(y: -40)
                        .padding(.bottom, 0)
                case 1:
                    SearchView()
                case 2:
                    InfoView()
                default:
                    HeaderView()
                    
                    mainViewImage
                    
                    RandomCharacterForTheDayView()
                        .offset(y: -40)
                    
                }
                
            Spacer(minLength: 0)
                
            TabView(screenIndex: $screenIndex)
                    .offset(y: -20)
            }
        }
    }
    
    private var mainViewImage: some View {
        VStack {
            RandomComicForTheDayView()
                .offset(y: -20)
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
        .offset(y: -12)
    }
}

#Preview {
    MainView()
}
