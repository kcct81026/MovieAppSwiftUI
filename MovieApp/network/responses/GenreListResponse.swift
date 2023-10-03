//
//  GenreListResponse.swift
//  MovieApp
//
//  Created by AyeSuNaing on 04/10/2023.
//

import Foundation

struct GenreListResponse : Codable {
    var genres : [GenreVO]?
    
    enum CodingKeys: String, CodingKey {
        case genres
    }
}

