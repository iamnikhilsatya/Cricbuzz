//
//  MovieView.swift
//  MovieDatabaseApp
//
//  Created by Nikhil Srikuramdasu on 21/10/23.
//

import SwiftUI

struct MovieView: View {
    @StateObject var viewModel = MoviesViewModel() // Create a state object for the view model.

    @State private var searchText = "" // Create a state variable for user search input.

    var body: some View {
        NavigationStack {
            VStack {
                // Search bar for entering and updating search queries.
                VStack(alignment: .leading, spacing: 2) {
                    Section {
                        HStack(spacing: 8) {
                            Image(systemName: "magnifyingglass")
                            TextField(" Search movies", text: $searchText)
                                .onChange(of: searchText) {
                                    if searchText.isEmpty {
                                        // Handle clearing search query
                                        viewModel.clearSearchResults()
                                    } else {
                                        viewModel.performSearch(query: searchText)
                                    }
                                }
                        }
                        .padding(.vertical, 7)
                        .padding(.horizontal, 8)
                        .font(.headline)
                        .background(.ultraThinMaterial)
                        .foregroundColor(Color.black.opacity(0.6))
                        .cornerRadius(16)
                    }
                }
                .padding(.horizontal, 22)
                .padding(.vertical, 4)

                // Display search results or regular options based on search text.
                if !searchText.isEmpty {
                    Section(header: Text("Search Results")) {
                        if viewModel.searchResults.isEmpty {
                            Text("No Results Found")
                            Spacer() // Spacer to center the view when there are no results.
                        } else {
                            // Display the search results using the MovieDetailView.
                            MovieDetailView(viewModel: viewModel, movies: viewModel.searchResults)
                        }
                    }
                } else {
                    // Display the list of movies in categories using OutlineGroup and NavigationLink.
                    List {
                        OutlineGroup(viewModel.listItem, children: \.children) { item in
                            HStack {
                                if let _ = item.parent {
                                    NavigationLink(destination: MovieDetailView(
                                        viewModel: viewModel, movies: viewModel.getMovies(category: item.parent ?? "", filter: item.name)
                                    )) {
                                        Text(item.name)
                                            .foregroundStyle(.orange)
                                    }
                                } else {
                                    if item.name == "All Movies" {
                                        NavigationLink {
                                            MovieDetailView(viewModel: viewModel, movies: viewModel.movies)
                                        } label: {
                                            Text(item.name)
                                        }
                                    } else {
                                        Text(item.name)
                                        
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
        }
    }
}


