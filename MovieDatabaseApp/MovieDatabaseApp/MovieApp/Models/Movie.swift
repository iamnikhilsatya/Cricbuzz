//
//  Movie.swift
//  MovieDatabaseApp
//
//  Created by Nikhil Srikuramdasu on 21/10/23.
//

import Foundation

struct Movie: Identifiable, Decodable {
    let id = UUID()
    let title: String
    let year: String?
    let rated: String?
    let released: String?
    let runtime: String?
    let genre: String?
    let director: String?
    let writer: String?
    let actors: String?
    let plot: String?
    let language: String?
    let country: String?
    let awards: String?
    let poster: String?
    let ratings: [Rating]?
    let metascore: String?
    let imdbRating: String?
    let imdbVotes: String?
    let imdbID: String?
    let type: String?
    let totalSeasons: String?
    let response: String
    let DVD: String?
    let boxOffice: String?
    let production: String?
    let website: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating = "imdbRating"
        case imdbVotes = "imdbVotes"
        case imdbID = "imdbID"
        case type = "Type"
        case totalSeasons = "totalSeasons"
        case response = "Response"
        case DVD = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case website = "Website"
    }
}

struct ListItem: Identifiable {
    var id = UUID()
    var name: String
    var parent: String?
    var children: [ListItem]?
    var isExpanded: Bool = false
}
