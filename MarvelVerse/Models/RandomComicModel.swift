//
//  RandomComicModel.swift
//  MarvelVerse
//
//  Created by Mateusz Krówczyński on 13/08/2024.
//

/*
 Example data from API
 
 {
   "code": 200,
   "status": "Ok",
   "copyright": "© 2024 MARVEL",
   "attributionText": "Data provided by Marvel. © 2024 MARVEL",
   "attributionHTML": "<a href=\"http://marvel.com\">Data provided by Marvel. © 2024 MARVEL</a>",
   "etag": "b542b0a99753d64e43b09c74034b077e951d5fed",
   "data": {
     "offset": 0,
     "limit": 20,
     "total": 1,
     "count": 1,
     "results": [
       {
         "id": 2,
         "digitalId": 3855,
         "title": "Pulse (2004) #6",
         "issueNumber": 6,
         "variantDescription": "",
         "description": "",
         "modified": "2015-11-23T17:27:26-0500",
         "isbn": "",
         "upc": "5960605483-00611",
         "diamondCode": "",
         "ean": "",
         "issn": "",
         "format": "Comic",
         "pageCount": 0,
         "textObjects": [
           {
             "type": "issue_solicit_text",
             "language": "en-us",
             "text": "PART 1 (OF 5)\r<br>Jessica Jones and Luke Cage's lives have been destroyed by the events of the Secret War, so what is Jessica going to do about it?  Fans of Secret War - feel The Pulse as it pounds out more gritty intrigue even as it welcomes a new artist: award-winning comics superstar Brent (RISING STARS, ASTRO CITY) Anderson!  \r<br>Guest-starring: Captain America, Luke Cage, Iron Fist, Nick Fury and many, many more.\r<br>"
           }
         ],
         "resourceURI": "http://gateway.marvel.com/v1/public/comics/2",
         "urls": [
           {
             "type": "detail",
             "url": "http://marvel.com/comics/issue/2/pulse_2004_6?utm_campaign=apiRef&utm_source=3868192c8c49fae15e0e0f38c607bec8"
           },
           {
             "type": "purchase",
             "url": "http://comicstore.marvel.com/The-Pulse-6/digital-comic/3855?utm_campaign=apiRef&utm_source=3868192c8c49fae15e0e0f38c607bec8"
           },
           {
             "type": "reader",
             "url": "http://marvel.com/digitalcomics/view.htm?iid=3855&utm_campaign=apiRef&utm_source=3868192c8c49fae15e0e0f38c607bec8"
           },
           {
             "type": "inAppLink",
             "url": "https://applink.marvel.com/issue/3855?utm_campaign=apiRef&utm_source=3868192c8c49fae15e0e0f38c607bec8"
           }
         ],
         "series": {
           "resourceURI": "http://gateway.marvel.com/v1/public/series/674",
           "name": "Pulse (2004 - 2006)"
         },
         "variants": [],
         "collections": [
           {
             "resourceURI": "http://gateway.marvel.com/v1/public/comics/2166",
             "name": "THE PULSE: SECRET WAR (Trade Paperback)"
           }
         ],
         "collectedIssues": [],
         "dates": [
           {
             "type": "onsaleDate",
             "date": "2004-11-10T00:00:00-0500"
           },
           {
             "type": "focDate",
             "date": "-0001-11-30T00:00:00-0500"
           },
           {
             "type": "unlimitedDate",
             "date": "2007-11-13T00:00:00-0500"
           },
           {
             "type": "digitalPurchaseDate",
             "date": "2014-09-02T00:00:00-0400"
           }
         ],
         "prices": [
           {
             "type": "printPrice",
             "price": 2.99
           },
           {
             "type": "digitalPurchasePrice",
             "price": 1.99
           }
         ],
         "thumbnail": {
           "path": "http://i.annihil.us/u/prod/marvel/i/mg/1/30/56538fd257915",
           "extension": "jpg"
         },
         "images": [
           {
             "path": "http://i.annihil.us/u/prod/marvel/i/mg/1/30/56538fd257915",
             "extension": "jpg"
           }
         ],
         "creators": {
           "available": 0,
           "collectionURI": "http://gateway.marvel.com/v1/public/comics/2/creators",
           "items": [],
           "returned": 0
         },
         "characters": {
           "available": 7,
           "collectionURI": "http://gateway.marvel.com/v1/public/comics/2/characters",
           "items": [
             {
               "resourceURI": "http://gateway.marvel.com/v1/public/characters/1009220",
               "name": "Captain America"
             },
             {
               "resourceURI": "http://gateway.marvel.com/v1/public/characters/1010776",
               "name": "Danny Rand"
             },
             {
               "resourceURI": "http://gateway.marvel.com/v1/public/characters/1009378",
               "name": "Jessica Jones"
             },
             {
               "resourceURI": "http://gateway.marvel.com/v1/public/characters/1010363",
               "name": "Logan"
             },
             {
               "resourceURI": "http://gateway.marvel.com/v1/public/characters/1009215",
               "name": "Luke Cage"
             },
             {
               "resourceURI": "http://gateway.marvel.com/v1/public/characters/1009471",
               "name": "Nick Fury"
             },
             {
               "resourceURI": "http://gateway.marvel.com/v1/public/characters/1009718",
               "name": "Wolverine"
             }
           ],
           "returned": 7
         },
         "stories": {
           "available": 2,
           "collectionURI": "http://gateway.marvel.com/v1/public/comics/2/stories",
           "items": [
             {
               "resourceURI": "http://gateway.marvel.com/v1/public/stories/2334",
               "name": "1 of 5 - Secret War arc",
               "type": "interiorStory"
             },
             {
               "resourceURI": "http://gateway.marvel.com/v1/public/stories/127841",
               "name": "cover to The Pulse (2004) #6",
               "type": "cover"
             }
           ],
           "returned": 2
         },
         "events": {
           "available": 0,
           "collectionURI": "http://gateway.marvel.com/v1/public/comics/2/events",
           "items": [],
           "returned": 0
         }
       }
     ]
   }
 }
 */

import Foundation

struct RandomComicResponse: Codable {
    let data: RandomComicResult?
}

struct RandomComicResult: Codable {
    let count: Int
    let results: [RandomComicModel]?
}

struct RandomComicModel: Codable, Identifiable {
    let id: Int?
    let title: String?
    let description: String?
    let thumbnail: [String:String]?
    let urls: [[String: String]]?
}


