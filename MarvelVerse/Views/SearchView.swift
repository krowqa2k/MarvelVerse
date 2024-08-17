//
//  SearchView.swift
//  MarvelVerse
//
//  Created by Mateusz Krówczyński on 16/08/2024.
//

import SwiftUI

struct SearchView: View {
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
    SearchView()
}
