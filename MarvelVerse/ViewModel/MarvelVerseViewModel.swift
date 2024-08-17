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
    @Published private(set) var comicSearch: [Comic] = []
    @Published var isLoading: Bool = false
    @Published var isLoadingSearch: Bool = false
    @Published var isLoadingCharacter: Bool = false
    @Published var isEmpty: Bool = false
    
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
    
    func getSearchDBData(query: String) {
        Task {
            isLoadingSearch = true
            isEmpty = false
            do {
                print("Query: \(query)")
                print("Started fetching")
                let searchData = try await WebService.getSearchDBData(query: query)
                
                if let results = searchData.data?.results {
                    self.comicSearch = results
                    print("Results: \(results)")
                } else {
                    print("No results found")
                }
            } catch {
                print("Error fetching comic data: \(error)")
            }
            isLoadingSearch = false
            if self.comicSearch.isEmpty {
                isEmpty = true
            }
            print("Finished fetching")
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

