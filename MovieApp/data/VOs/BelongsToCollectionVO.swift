//
//  BelongsToCollectionVO.swift
//  MovieApp
//
//  Created by AyeSuNaing on 04/10/2023.
//

import Foundation

struct BelongsToCollectionVO :Codable {
    
     var id : Int?
     var name : String?
     var posterPath : String?
     var backdropPath : String?
    
    enum CodingKeys: String, CodingKey{
        case id
        case name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
    /*
    func toBelongsToCollectionObj() -> BelongsToCollectionObject{
        
    let obj = BelongsToCollectionObject()
        obj.id = id
        obj.name = name
        obj.posterPath = posterPath
        obj.backdropPath = backdropPath
        return obj
    }
*/
}
