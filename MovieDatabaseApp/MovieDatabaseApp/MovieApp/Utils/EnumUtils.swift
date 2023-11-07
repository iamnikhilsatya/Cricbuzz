//
//  EnumUtils.swift
//  MovieDatabaseApp
//
//  Created by yalla lalitesh on 07/11/23.
//

import Foundation

// Define the Filter enum for category selection.
enum FilterBased: String {
    case year = "Year"
    case genre = "Genre"
    case director = "Directors"
    case actor = "Actors"
    case all = "All Movies"
}
enum SortList: String {
    case alphabet = "Alphabet"
    case rating = "Rating"
    case year = "Year"
}
