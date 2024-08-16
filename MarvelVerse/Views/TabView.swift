//
//  TabView.swift
//  MarvelVerse
//
//  Created by Mateusz Krówczyński on 16/08/2024.
//

import SwiftUI

struct TabView: View {
    
    @Binding var screenIndex: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.ultraThinMaterial)
                .frame(width: 360, height: 60)
            HStack(spacing: 16){
                ZStack{
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(.marvelRed)
                        .frame(width: 90, height: 40)
                        .opacity(self.screenIndex == 0 ? 1 : 0)
                    HStack(spacing: 4){
                        Image(systemName: "house.fill")
                            .font(.title3)
                        Text("Home")
                            .font(.callout)
                    }
                    .foregroundStyle(self.screenIndex == 0 ? .marvelWhite : .marvelBlack)
                }
                .onTapGesture {
                    self.screenIndex = 0
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(.marvelRed)
                        .frame(width: 90, height: 40)
                        .opacity(self.screenIndex == 1 ? 1 : 0)
                    HStack(spacing: 4){
                        Image(systemName: "magnifyingglass")
                            .font(.title3)
                        Text("Search")
                            .font(.callout)
                    }
                    .foregroundStyle(self.screenIndex == 1 ? .marvelWhite : .marvelBlack)
                }
                .onTapGesture {
                    self.screenIndex = 1
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(.marvelRed)
                        .frame(width: 90, height: 40)
                        .opacity(self.screenIndex == 2 ? 1 : 0)
                    HStack(spacing: 4){
                        Image(systemName: "info.circle")
                            .font(.title3)
                        Text("Info")
                            .font(.callout)
                    }
                    .foregroundStyle(self.screenIndex == 2 ? .marvelWhite : .marvelBlack)
                }
                .onTapGesture {
                    self.screenIndex = 2
                }
            }
        }
        .animation(.spring, value: screenIndex)
    }
}

#Preview {
    TabView(screenIndex: .constant(0))
}
