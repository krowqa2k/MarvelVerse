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

    static let lastFetchKey = "lastFetchDate"
    
    // Generowanie losowego ID komiksu
    static func generateRandomComicID() -> String {
        return String(Int.random(in: 2..<27600))
    }

    // Sprawdzanie, czy minęło 24 godziny od ostatniego wywołania API
    static func shouldFetchNewComic() -> Bool {
        guard let lastFetch = UserDefaults.standard.object(forKey: lastFetchKey) as? Date else {
            return true // Nigdy nie pobrano, można pobrać nowy
        }
        let timeInterval = Date().timeIntervalSince(lastFetch)
        return timeInterval >= 24 * 60 * 60 // 24 godziny w sekundach
    }

    // Główna funkcja pobierania losowego komiksu
    static func getRandomComicData() async throws -> RandomComicResponse {
        
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
                        let decoder = try JSONDecoder().decode(RandomComicResponse.self, from: data)
                        
                        // Zapisanie daty udanego pobrania
                        UserDefaults.standard.set(Date(), forKey: lastFetchKey)
                        
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
    
}
