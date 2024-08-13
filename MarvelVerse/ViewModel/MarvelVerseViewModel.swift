//
//  MarvelVerseViewModel.swift
//  MarvelVerse
//
//  Created by Mateusz Krówczyński on 13/08/2024.
//

import Foundation

@MainActor
final class MarvelVerseViewModel: ObservableObject {
    
    @Published private(set) var randomComic: [RandomComicModel] = []
    @Published var isLoading: Bool = true
    
    func getRandomComicData() async {
        isLoading = true
        do {
            let randomComic = try await WebService.getRandomComicData()
            
            if let results = randomComic.data?.results {
                self.randomComic = results
                self.isLoading = false
            } else {
                print("No comic results found.")
            }
        } catch {
            print("Error fetching comic data: \(error)")
            self.isLoading = false
        }
    }
    
    func extractImage(data: [String: String]) -> String {
        
        let path = data["path"] ?? ""
        let ext = data["extension"] ?? ""
        
        let thumbnail = "\(path).\(ext)"
        return thumbnail
        
    }
}
