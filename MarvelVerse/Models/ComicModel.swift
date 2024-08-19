//
//  ComicModel.swift
//  MarvelVerse
//
//  Created by Mateusz Krówczyński on 14/08/2024.
//

import Foundation

struct ComicResponse: Codable {
    let data: ComicResult?
}

struct ComicResult: Codable {
    let count: Int
    let results: [Comic]?
}

struct Comic: Codable, Identifiable {
    let id: Int?
    let title: String?
    let description: String?
    let urls: [[String:String]]?
    let series: Series?
    let creators: Creators?
    let thumbnail: [String:String]
    
    static var mock: Comic {
        Comic(
            id: 59551,
            title: "Wolverine (2024) #2",
            description: "WHERE GOES THE WENDIGO?!...",
            urls: [["detail": "http://marvel.com/comics/issue/113524/wolverine_2024_2?utm_campaign=apiRef&utm_source=2b23e25a76e180235beae440efbd1949"]],
            series: Series(resourceURI: "http://gateway.marvel.com/v1/public/series/38960", name: "Wolverine (2024 - Present)"),
            creators: Creators(
                available: 5,
                collectionURI: "http://gateway.marvel.com/v1/public/comics/113524/creators",
                items: [
                    CreatorsItem(
                        resourceURI: "http://gateway.marvel.com/v1/public/creators/13081",
                        name: "Saladin Ahmed",
                        role: "writer"
                    ),
                    CreatorsItem(
                        resourceURI: "http://gateway.marvel.com/v1/public/creators/12313",
                        name: "Mark Basso",
                        role: "editor"
                    )
                ],
                returned: 5
            ),
            thumbnail: ["path": "http://i.annihil.us/u/prod/marvel/i/mg/1/30/56538fd257915"]
        )
    }
}

struct Series: Codable {
    let resourceURI: String?
    let name: String?
}

struct Creators: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [CreatorsItem]?
    let returned: Int?
}

struct CreatorsItem: Codable {
    let resourceURI: String?
    let name: String?
    let role: String?
}


