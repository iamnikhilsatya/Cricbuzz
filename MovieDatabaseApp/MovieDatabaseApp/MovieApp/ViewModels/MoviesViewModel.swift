//
//  MoviesViewModel.swift
//  MovieDatabaseApp
//
//  Created by Nikhil Srikuramdasu on 21/10/23.
//

import Foundation

// View model responsible for managing movie data and filters.
class MoviesViewModel: ObservableObject {
    // Published property for all movies data.
    @Published var movies: [Movie] = []
    // Published property for search results.
    @Published var searchResults: [Movie] = []
    // Published property for the list of ListItem objects.
    @Published var listItem: [ListItem] = []
    // Initialize the MoviesViewModel and load movies data from a JSON file.
    init() {
        movies = JSONLoader.load("MoviesData.json", as: [Movie].self)
        generateListItem()
    }
    
    // Generate a list of years from date ranges
    func generateListItem() {
        var itemList: [ListItem] = []
        itemList.append(generateListItemWithChildren(category: "Year", children: getSublist(category: "Year")))
        itemList.append(generateListItemWithChildren(category: "Genre", children: getSublist(category: "Genre")))
        itemList.append(generateListItemWithChildren(category: "Directors", children: getSublist(category: "Directors")))
        itemList.append(generateListItemWithChildren(category: "Actors", children: getSublist(category: "Actors")))
        itemList.append(generateListItemWithChildren(category: "All Movies", children: getSublist(category: "All Movies")))
        listItem = itemList
    }
    
    // Generate a ListItem object with child items for a specific category.
    func generateListItemWithChildren(category: String, children: [String]) -> ListItem {
        var parentItem = ListItem(name: category, children: [])
        parentItem.children = children.map { ListItem(name: $0, parent: category, children: nil) }
        return parentItem
    }
    
    // Generate years from date ranges to be used as subcategories.
    func generateYears(from dateRanges: [String]) -> [String] {
        var result: [String] = []
        
        for dateRange in dateRanges {
            if dateRange.contains("–") {
                let rangeComponents = dateRange.components(separatedBy: "–")
                if let startYear = Int(rangeComponents[safe: 0] ?? ""), let endYear = Int(rangeComponents[safe: 1] ?? "") {
                    result.append(String(startYear))
                    result.append(String(endYear))
                }
                else {
                    result.append(String(Int(rangeComponents[safe: 0] ?? "") ?? 0))
                }
            } else if let singleYear = Int(dateRange) {
                result.append(String(singleYear))
            }
        }
        
        return result
    }
    
    // Get a list of subcategories based on the selected category.
    func getSublist(category: String) -> [String] {
        let values: [String]
        
        switch FilterBased(rawValue: category) {
        case .year:
            values = generateYears(from: movies.compactMap({$0.year}))
        case .genre:
            values = movies.compactMap { $0.genre?.components(separatedBy: ", ") }.flatMap { $0 }
        case .director:
            values = movies.compactMap { $0.director?.components(separatedBy: ", ") }.flatMap { $0 }
        case .actor:
            values = movies.compactMap { $0.actors?.components(separatedBy: ", ") }.flatMap { $0 }
        default:
            values = []
        }
        
        return Array(Set(values)).sorted() // Remove duplicates and sort
    }
    
    // Get filtered movies based on the selected category and filter.
    func getMovies(category: String, filter: String?) -> [Movie] {
        let filteredMovies: [Movie]
        
        switch FilterBased(rawValue: category) {
        case .year:
            if let filter = filter {
                filteredMovies = movies.filter { $0.year?.contains(filter) ?? false }
            } else {
                filteredMovies = movies
            }
        case .genre:
            if let filter = filter {
                filteredMovies = movies.filter { $0.genre?.contains(filter) ?? false}
            } else {
                filteredMovies = movies
            }
        case .director:
            if let filter = filter {
                filteredMovies = movies.filter { $0.director?.contains(filter) ?? false }
            } else {
                filteredMovies = movies
            }
        case .actor:
            if let filter = filter {
                filteredMovies = movies.filter { $0.actors?.contains(filter) ?? false }
            } else {
                filteredMovies = movies
            }
        case .all:
            filteredMovies = movies
        default:
            filteredMovies = movies
        }
        
        return filteredMovies
    }
    
    // Clear search results.
    func clearSearchResults() {
        searchResults = [] // Clear search results
    }
    
    // Perform a search based on the provided query.
    func performSearch(query: String) {
        if query.isEmpty {
            // If the search query is empty, reset the movies list to its original state
            searchResults = movies
        } else {
            // Filter movies based on the search query (search by title, genre, actor, director)
            searchResults = movies.filter { movie in
                return movie.title.lowercased().contains(query.lowercased()) ||
                movie.genre?.lowercased().contains(query.lowercased()) ?? false ||
                movie.actors?.lowercased().contains(query.lowercased()) ?? false ||
                movie.director?.lowercased().contains(query.lowercased()) ?? false
            }
        }
    }
        
    // Filter movies based on the selected filter
    func filteredMovies(filterList: [Movie], selectedFilter: String) -> [Movie] {
        switch SortList(rawValue: selectedFilter) {
        case .alphabet:
            return filterList.sorted{ $0.title < $1.title }
        case .year:
            return filterList.sorted { $0.year ?? "" < $1.year ?? "" }
        case .rating:
            return filterList.sorted { getAverageRating(ratings: $0.ratings ?? [], title: $0.title) < getAverageRating(ratings: $1.ratings ?? [], title: $0.title)}
        case .none:
            return filterList
        }
    }
    
    func getAverageRating(ratings: [Rating], title: String) -> Double {
        var totalRating = 0.0
        var numberOfRatings = 0
        
        for rating in ratings {
            let value = ratingValue(source: rating.source ?? "", value: rating.value ?? "")
            if let ratingValue = Double(value) {
                totalRating += ratingValue
                numberOfRatings += 1
            }
        }
        
        if numberOfRatings > 0 {
            return totalRating / Double(numberOfRatings)
        } else {
            return 0.0 // Return 0 if no valid ratings are found
        }
    }
    
    func ratingValue(source: String, value: String) -> String {
        guard let ratingSource = RatingSource(rawValue: source) else {
            return "0"
        }  

        switch ratingSource {
        case .internetMovieDatabase:
            if value.contains("/") {
                let ratingComponents = value.components(separatedBy: "/")
                if let rating = Double(ratingComponents.first ?? "") {
                    return String(format: "%.1f", rating)
                }
            }
        case .rottenTomatoes:
            if value.hasSuffix("%"), let rating = Double(String(value.dropLast())) {
                return String(format: "%.1f", rating / 10.0)
            }
        case .metacritic:
            if value.contains("/") {
                let ratingComponents = value.components(separatedBy: "/")
                if let rating = Double(ratingComponents.first ?? "") {
                    return String(format: "%.1f", rating / 10.0)
                }
            }
        }

        return "0"
    }
}

