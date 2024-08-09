//
//  MainView.swift
//  MarvelVerse
//
//  Created by Mateusz Krówczyński on 09/08/2024.
//

import SwiftUI

struct MainView: View {

    var body: some View {
        ZStack {
            Color.marvelWhite.ignoresSafeArea()
            VStack {
                HeaderView()
                Spacer()
            }
        }
    }
}

#Preview {
    MainView()
}
