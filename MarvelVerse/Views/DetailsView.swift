//
//  DetailsView.swift
//  MarvelVerse
//
//  Created by Mateusz Krówczyński on 18/08/2024.
//

import SwiftUI

struct DetailsView: View {
    
    @StateObject private var viewModel = MarvelVerseViewModel()
    var imageName: String = Constants.mockImage
    var comic: Comic = .mock
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.marvelWhite.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 26){
                HStack(alignment: .top, spacing: 14){
                    ImageLoader(imageURL: imageName)
                        .frame(width: 130, height: 200)
                        .cornerRadius(4)
                    
                    VStack(alignment: .leading, spacing: 8){
                        Text(comic.title ?? "")
                            .foregroundStyle(.marvelBlack)
                            .font(.headline)
                        
                        Text(comic.series?.name ?? "")
                            .foregroundStyle(.marvelBlack.opacity(0.5))
                            .font(.caption)
                        
                        Image("marvel_comics")
                            .resizable()
                            .frame(width: 60, height: 60)
                        
                        Rectangle()
                            .fill(Color.marvelRed)
                            .frame(maxWidth: 180)
                            .frame(height: 80)
                            .cornerRadius(8)
                            .overlay {
                                Link("READ NOW", destination: {
                                    if let urlString = viewModel.extractURL(data: comic.urls ?? [["":""]]),
                                       let url = URL(string: urlString) {
                                        return url
                                    } else {
                                        return URL(string: "https://www.google.com")!
                                    }
                                }())
                                .tint(.marvelWhite)
                            }
                    }
                }
                
                VStack(alignment: .leading, spacing: 4){
                    Text("CREATORS")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.marvelBlack)
                    
                    HStack(spacing: 4){
                        if let comicCreators = comic.creators?.items {
                            ForEach(comicCreators, id: \.resourceURI){ creator in
                                HStack(spacing: 4){
                                    Text("*'\(creator.name ?? "")*'")
                                        .font(.subheadline)
                                        .foregroundStyle(.marvelBlack)
                                }
                            }
                        }
                        
                    }
                    .frame(maxHeight: 80, alignment: .top)
                }
                
                VStack(alignment: .leading, spacing: 4){
                    Text("SYNOPSIS")
                        .font(.headline)
                        .foregroundStyle(.marvelRed)
                    ScrollView(.vertical){
                        Text(comic.description ?? "")
                            .foregroundStyle(.marvelBlack.opacity(0.9))
                            .font(.callout)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal)
                            .frame(width: UIScreen.main.bounds.width - 20)
                    }
                }
                Spacer()
            }
            .padding(.top, 80)
        }
        .overlay(alignment: .topLeading, content: {
            ZStack{
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(.marvelRed)
                Image(systemName: "xmark")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundStyle(.marvelWhite)
            }
            .padding(.horizontal)
            .onTapGesture {
                dismiss()
            }
        })
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    DetailsView()
}
