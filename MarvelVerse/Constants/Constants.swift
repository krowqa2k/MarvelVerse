//
//  Constants.swift
//  MarvelVerse
//
//  Created by Mateusz Krówczyński on 13/08/2024.
//

import Foundation

struct Constants {
    static let mockImage = "https://picsum.photos/200/300"
    static let noImage = "https://static-00.iconduck.com/assets.00/no-image-icon-2048x2048-2t5cx953.png"
    
    static let privateKey: String = "5bc503c5a00b453ccff4cfc6912913f325409874"
    static let publicKey: String = "2b23e25a76e180235beae440efbd1949"
    
    static let ts = String(Date().timeIntervalSince1970)
    static let hash = (ts + privateKey + publicKey).MD5
}
