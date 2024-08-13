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

    static func generateRandomComicID() -> String {
        return String(Int.random(in: 2..<27600))
    }

    static func getRandomComicData() async throws -> RandomComicResponse {
        
        let privateKey: String = "5bc503c5a00b453ccff4cfc6912913f325409874"
        let publicKey: String = "2b23e25a76e180235beae440efbd1949"
        
        let ts = String(Date().timeIntervalSince1970)
        let hash = (ts + privateKey + publicKey).MD5
        
        var retryCount = 0
        let maxRetries = 5

        while retryCount < maxRetries {
            let randomComicID = generateRandomComicID()
            let urlString = "https://gateway.marvel.com/v1/public/comics/\(randomComicID)?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
            
            guard let url = URL(string: urlString) else {
                throw ErrorCases.invalidURL
            }
            
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200:
                        let decoder = try JSONDecoder().decode(RandomComicResponse.self, from: data)
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
