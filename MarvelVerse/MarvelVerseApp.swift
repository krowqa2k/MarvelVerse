//
//  MarvelVerseApp.swift
//  MarvelVerse
//
//  Created by Mateusz Krówczyński on 09/08/2024.
//

import SwiftUI

@main
struct MarvelVerseApp: App {
    
    @StateObject private var viewModel = MarvelVerseViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                MainView()
            }
            .environmentObject(viewModel)
        }
    }
}
