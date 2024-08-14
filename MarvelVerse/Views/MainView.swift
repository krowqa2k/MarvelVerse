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
            VStack {
                HeaderView()
                
                mainViewImage
                
                ScrollView(.vertical) {
                    ForEach(1..<22) { i in
                        Text("Placeholder: \(i)")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .scrollIndicators(.hidden)
                
                Spacer()
            }
        }
    }
    
    private var mainViewImage: some View {
        VStack {
            RandomComicForTheDayView()
                .padding(.top)
        }
        .frame(maxWidth: .infinity)
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
