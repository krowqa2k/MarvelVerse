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
    let thumbnail: [String:String]

    
    static var mock: Comic {
        Comic(
            id: 59551,
            title: "Spider-Man (2016) #6 (Anka Mighty Men Variant)",
            description: "",
            urls: [["detail": "http://marvel.com/comics/issue/59551/spider-man_2016_6_anka_mighty_men_variant/anka_mighty_men_variant?utm_campaign=apiRef&utm_source=2b23e25a76e180235beae440efbd1949"]],
            series: Series.init(resourceURI: "http://gateway.marvel.com/v1/public/series/20508", name: "Spider-Man (2016 - 2018)"),
            thumbnail: ["path": "http://i.annihil.us/u/prod/marvel/i/mg/1/30/56538fd257915"]
        )
    }
}


