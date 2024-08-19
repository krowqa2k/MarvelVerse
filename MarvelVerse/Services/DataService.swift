//
//  DataService.swift
//  MarvelVerse
//
//  Created by Mateusz Krówczyński on 13/08/2024.
//

import Foundation
import CryptoKit

enum ErrorCases: LocalizedError {
    case invalidURL
    case InvalidResponse
    case invalidData
    case retryLimitExceeded
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL found"
        case .InvalidResponse: return "Invalid URL response"
        case .invalidData: return "Invalid Data found"
        case .retryLimitExceeded: return "Retry limit exceeded"
        }
    }
}

final class WebService {

    static let lastFetchKeyComic = "lastFetchDateComic"
    static let lastFetchKeyCharacter = "lastFetchDateCharacter"
    
    // Generowanie losowego ID komiksu
    static func generateRandomComicID() -> String {
        return String(Int.random(in: 2..<27600))
    }
    
    static func generateRandomCharacterID() -> String {
        return String(Int.random(in: 1009148..<1011137))
    }

    // Sprawdzanie, czy minęło 24 godziny od ostatniego wywołania API
    static func shouldFetchNewComic() -> Bool {
        guard let lastFetch = UserDefaults.standard.object(forKey: lastFetchKeyComic) as? Date else {
            return true // Nigdy nie pobrano, można pobrać nowy
        }
        let timeInterval = Date().timeIntervalSince(lastFetch)
        return timeInterval >= 24 * 60 * 60 // 24 godziny w sekundach
    }
    
    static func shouldFetchNewCharacter() -> Bool {
        guard let lastFetch = UserDefaults.standard.object(forKey: lastFetchKeyCharacter) as? Date else {
            return true
        }
        let timeInterval = Date().timeIntervalSince(lastFetch)
        return timeInterval >= 24 * 60 * 60
    }

    // Główna funkcja pobierania losowego komiksu
    static func getRandomComicData() async throws -> ComicResponse {
        
        // Sprawdzenie, czy można wykonać nowe wywołanie
        guard shouldFetchNewComic() else {
            throw ErrorCases.retryLimitExceeded // Możesz zmienić to na inny przypadek błędu lub zwrócić poprzednie dane
        }

        var retryCount = 0
        let maxRetries = 1000

        while retryCount < maxRetries {
            let randomComicID = generateRandomComicID()
            let urlString = "https://gateway.marvel.com/v1/public/comics/\(randomComicID)?ts=\(Constants.ts)&apikey=\(Constants.publicKey)&hash=\(Constants.hash)"
            
            guard let url = URL(string: urlString) else {
                throw ErrorCases.invalidURL
            }
            
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200:
                        let decoder = try JSONDecoder().decode(ComicResponse.self, from: data)
                        
                        // Zapisanie daty udanego pobrania
                        UserDefaults.standard.set(Date(), forKey: lastFetchKeyComic)
                        
                        return decoder
                    case 404:
                        retryCount += 1
                    default:
                        throw ErrorCases.InvalidResponse
                    }
                }
                
            } catch {
                print("Error fetching comic data: \(error.localizedDescription)")
                retryCount += 1
            }
        }
        
        throw ErrorCases.retryLimitExceeded
    }
    
    
    static func getRandomCharacterData() async throws -> RandomCharacterResponse {
        
        guard shouldFetchNewCharacter() else {
            throw ErrorCases.retryLimitExceeded
        }
        
        var retryCount = 0
        let maxRetries = 1000
        
        while retryCount < maxRetries {
            let randomCharacterID = generateRandomCharacterID()
            let urlString = "https://gateway.marvel.com/v1/public/characters/\(randomCharacterID)?ts=\(Constants.ts)&apikey=\(Constants.publicKey)&hash=\(Constants.hash)"
            
            guard let url = URL(string: urlString) else {
                throw ErrorCases.invalidURL
            }
            
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200:
                        let decoder = try JSONDecoder().decode(RandomCharacterResponse.self, from: data)
                        
                        UserDefaults.standard.set(Date(), forKey: lastFetchKeyCharacter)
                        
                        return decoder
                    case 404:
                        retryCount += 1
                    default:
                        throw ErrorCases.InvalidResponse
                    }
                }
                
            } catch {
                print("Error fetching comic data: \(error.localizedDescription)")
                retryCount += 1
            }
        }
        
        throw ErrorCases.retryLimitExceeded
    }
    
    static func getSearchDBData(query: String) async throws -> ComicResponse {
        guard !query.isEmpty else {
            throw ErrorCases.invalidURL
        }
        let queryEncoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://gateway.marvel.com/v1/public/comics?title=\(queryEncoded)&limit=15&ts=\(Constants.ts)&apikey=\(Constants.publicKey)&hash=\(Constants.hash)"
        
        guard let url = URL(string: urlString) else {
            throw ErrorCases.invalidURL
        }
        
        do {
            print("Started fetching")
            let (data, response) = try await URLSession.shared.data(from: url)
            
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    let decoder = try JSONDecoder().decode(ComicResponse.self, from: data)
                    print("Fetched data")
                    return decoder
                case 404:
                    throw ErrorCases.InvalidResponse
                default:
                    throw ErrorCases.InvalidResponse
                }
            }
        } catch {
            print("Error fetching comic data: \(error.localizedDescription)")
        }
        
        throw ErrorCases.retryLimitExceeded
    }
}
