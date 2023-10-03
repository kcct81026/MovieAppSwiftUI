//
//  CreditsListResponse.swift
//  MovieApp
//
//  Created by AyeSuNaing on 04/10/2023.
//

import Foundation

struct CreditsListResponse : Codable {
    var id : Int?
    var cast : [ActorVO]?
    var crew : [ActorVO]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case cast
        case crew
    }
}
