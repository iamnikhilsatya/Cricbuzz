//
//  Rating.swift
//  MovieDatabaseApp
//
//  Created by Nikhil Srikuramdasu on 21/10/23.
//

import Foundation

struct Rating: Decodable {
    let source: String?
    let value: String?
    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}

enum RatingSource: String {
    case internetMovieDatabase = "Internet Movie Database"
    case rottenTomatoes = "Rotten Tomatoes"
    case metacritic = "Metacritic"
}
