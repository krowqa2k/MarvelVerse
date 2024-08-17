//
//  SearchView.swift
//  MarvelVerse
//
//  Created by Mateusz Krówczyński on 16/08/2024.
//

import SwiftUI

struct SearchView: View {

    @State private var query: String = ""
    @StateObject private var viewModel: MarvelVerseViewModel = MarvelVerseViewModel()
    
    var body: some View {
        ZStack {
            Color.marvelWhite.ignoresSafeArea()
            VStack(spacing: 8){
                if viewModel.isLoadingSearch {
                    ProgressView()
                        .tint(.marvelRed)
                        .background(
                            UnevenRoundedRectangle(
                                topLeadingRadius: 8,
                                topTrailingRadius: 8
                            )
                        )
                        .offset(y: -10)
                } else {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .font(.title)
                            .foregroundStyle(.marvelRed)
                            .padding(.leading)
                            .padding(.trailing, 0)
                        TextField("Search Movies, TV Series...", text: $query) {
                            Task {
                                viewModel.getSearchDBData(query:query)
                            }
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.trailing,12)
                        .padding(.leading, 0)
                        .frame(maxWidth: .infinity)
                        .tint(.marvelWhite)
                        
                        if !query.isEmpty {
                            Image(systemName: "xmark.circle.fill")
                                .padding(.trailing,24)
                                .background(Color.marvelBlack.opacity(0.01))
                                .foregroundStyle(.marvelBlack)
                                .onTapGesture {
                                    query = ""
                                    Task {
                                        viewModel.getSearchDBData(query:query)
                                    }
                                }
                        }
                    }
                    .padding(.top)
                    .background(
                        UnevenRoundedRectangle(
                            topLeadingRadius: 8,
                            topTrailingRadius: 8
                        )
                    )
                    .offset(y: -10)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    SearchView()
}
