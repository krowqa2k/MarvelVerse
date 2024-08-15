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
    @Published private(set) var randomCharacter: [RandomCharacterModel] = []
    @Published var isLoading: Bool = true
    @Published var isLoadingCharacter: Bool = true
    
    // Klucz do UserDefaults
    private let lastComicKey = "lastComicData"
    private let lastCharacterKey = "lastCharacterData"
    
    func getRandomComicData() async {
        isLoading = true
        
        // Sprawdzanie, czy można pobrać nowy komiks
        do {
            let randomComic = try await WebService.getRandomComicData()
            
            if let results = randomComic.data?.results {
                self.randomComic = results
                
                // Zapisanie komiksu w UserDefaults
                if let encodedComic = try? JSONEncoder().encode(results) {
                    UserDefaults.standard.set(encodedComic, forKey: lastComicKey)
                }
                
                self.isLoading = false
            } else {
                print("No comic results found.")
                loadLastComicFromStorage()
            }
        } catch {
            print("Error fetching comic data: \(error)")
            loadLastComicFromStorage()
        }
    }
    
    func getRandomCharacterData() async {
        isLoadingCharacter = true
        
        do {
            let randomCharacter = try await WebService.getRandomCharacterData()
            
            if let results = randomCharacter.data?.results {
                self.randomCharacter = results
                
                if let encodedCharacter = try? JSONEncoder().encode(results){
                    UserDefaults.standard.set(encodedCharacter, forKey: lastCharacterKey)
                }
                
                self.isLoadingCharacter = false
            } else {
                print("No character results found.")
                loadLastCharacterFromStorage()
            }
            
        } catch {
            print("Error fetching character data. \(error)")
            loadLastCharacterFromStorage()
        }
    }
    
    
    
    // Funkcja ładowania ostatniego komiksu z UserDefaults
    private func loadLastComicFromStorage() {
        if let savedComicData = UserDefaults.standard.data(forKey: lastComicKey),
           let savedComic = try? JSONDecoder().decode([RandomComicModel].self, from: savedComicData) {
            self.randomComic = savedComic
        } else {
            print("No saved comic found.")
        }
        self.isLoading = false
    }
    
    private func loadLastCharacterFromStorage() {
        if let savedCharacterData = UserDefaults.standard.data(forKey: lastCharacterKey),
           let savedCharacter = try? JSONDecoder().decode([RandomCharacterModel].self, from: savedCharacterData) {
            self.randomCharacter = savedCharacter
        } else {
            print("No saved character found.")
        }
        self.isLoadingCharacter = false
    }
    
    func extractImage(data: [String: String]) -> String {
        let path = data["path"] ?? ""
        let ext = data["extension"] ?? ""
        return "\(path).\(ext)"
    }
}

