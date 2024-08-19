//
//  InfoView.swift
//  MarvelVerse
//
//  Created by Mateusz Krówczyński on 16/08/2024.
//

import SwiftUI

struct InfoView: View {
    
    let aboutMe = URL(string: "https://github.com/krowqa2k")!
    let marvelURL = URL(string: "https://developer.marvel.com")!
    
    var body: some View {
        ZStack {
            Color.marvelWhite.ignoresSafeArea()
            
            VStack(spacing: 12) {
                Text("Info About Creator")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.marvelRed)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                HStack(spacing: 12) {
                    Image("creatorImage")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding(.leading)
                    Spacer(minLength: 0)
                    
                    VStack(alignment: .leading, spacing: 4){
                        Text("App created by Mateusz Krówczyński.")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(.marvelBlack)
                        Text("👇 You can reach me here.")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(.gray)
                        Link("Github profile.", destination: aboutMe)
                            .foregroundStyle(.blue)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.bottom, 50)
                
                Text("Marvel API")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.marvelRed)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                VStack(alignment: .leading, spacing: 12) {
                    Image("marvel_logo")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width - 200, height: 50)
                        .cornerRadius(6)
                        .padding(.leading)
                    
                    VStack(alignment: .leading, spacing: 8){
                        Text("The data that is used in this app comes from free API from The Marvel Developer Portal.")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(.marvelBlack)
                        Text("👇 Visit Marvel Developer Portal.")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(.gray)
                        Link("MarvelAPI", destination: marvelURL)
                            .foregroundStyle(.blue)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                }
                
                Spacer()
            }
            .padding(.top)
            .background(
                UnevenRoundedRectangle(
                    topLeadingRadius: 8,
                    topTrailingRadius: 8
                )
                .fill(.marvelWhite)
            )
            .offset(y: -10)
        }
    }
}

#Preview {
    InfoView()
}
