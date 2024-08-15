//
//  RandomCharacterModel.swift
//  MarvelVerse
//
//  Created by Mateusz Krówczyński on 15/08/2024.
//

import Foundation

struct RandomCharacterResponse: Codable {
    let data: RandomCharacterResult?
}

struct RandomCharacterResult: Codable {
    let results: [RandomCharacterModel]?
}

struct RandomCharacterModel: Identifiable, Codable {
    let id: Int?
    let name, description: String?
    let comics: Comics?
    let urls: [[String:String]]?
    let thumbnail: [String:String]?
    
    static var mock: RandomCharacterModel {
        RandomCharacterModel(
            id: 1009149,
            name: "Abyss",
            description: "",
            comics: Comics(available: 8, collectionURI: "", items: [ComicsItem(resourceURI: "", name: "")], returned: 8),
            urls: [["detail":"http://marvel.com/characters/85/abyss?utm_campaign=apiRef&utm_source=2b23e25a76e180235beae440efbd1949"]],
            thumbnail: ["path":"http://i.annihil.us/u/prod/marvel/i/mg/9/30/535feab462a64"]
        )
    }
}

struct Comics: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [ComicsItem]?
    let returned: Int?
}

struct ComicsItem: Codable {
    let resourceURI: String?
    let name: String?
}
