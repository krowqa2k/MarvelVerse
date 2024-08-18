//
//  MainView.swift
//  MarvelVerse
//
//  Created by Mateusz Krówczyński on 09/08/2024.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var viewModel: MarvelVerseViewModel
    @State private var screenIndex: Int = 0
    private let marvelMainImage: String = "marvel_main"

    var body: some View {
        ZStack {
            Color.marvelWhite.ignoresSafeArea()
            VStack(spacing: 0) {
                HeaderView()
                switch screenIndex{
                case 0:
                    mainViewImage
                    
                    RandomCharacterForTheDayView()
                        .offset(y: -50)
                        .padding(.bottom, 0)
                case 1:
                    SearchView()
                case 2:
                    InfoView()
                default:
                    mainViewImage
                    
                    RandomCharacterForTheDayView()
                    
                }
                
            Spacer(minLength: 0)
                
            }
            TabView(screenIndex: $screenIndex)
                .offset(y: UIScreen.main.bounds.width - 20)
        }
    }
    
    private var mainViewImage: some View {
        VStack {
            RandomComicForTheDayView()
                .offset(y: -20)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 360)
        .background(Color.marvelWhite)
        .clipShape(
            UnevenRoundedRectangle(
                topLeadingRadius: 8,
                topTrailingRadius: 8
            )
        )
        .offset(y: -10)
    }
}

#Preview {
    MainView()
        .environmentObject(MarvelVerseViewModel())
}
