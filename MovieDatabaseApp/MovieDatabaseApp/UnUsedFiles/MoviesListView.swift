//
//  MoviesListView.swift
//  MovieDatabaseApp
//
//  Created by Nikhil Srikuramdasu on 21/10/23.
//

import SwiftUI

struct MoviesListView: View {
    @ObservedObject var viewModel: MoviesViewModel
    @State private var selectedCategory: String?
    @State private var selectedSubCategory: String?
    @State private var searchText: String = ""
    var categories: [String] = ["Year", "Genre", "Directors", "Actors"]
    @State var selectedTab: Int = 0
    var currentGradient: [Color] = [Color("backgroundColor"), Color("grey")]
    var selectedGradient: [Color] = [Color("majenta"), Color("backgroundColor")]
    
    var body: some View {
        ZStack {
            VStack {
                VStack(alignment: .leading, spacing: 2) {
                    Section {
                        HStack(spacing: 8) {
                            Image(systemName: "magnifyingglass")
                            TextField(" Search movies", text: $searchText)
                                .onChange(of: searchText) { newValue in
                                    if newValue.isEmpty {
                                        // Handle clearing search query
                                        viewModel.clearSearchResults()
                                    } else {
                                        viewModel.performSearch(query: newValue)
                                    }
                                }
                                .onSubmit {
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
                // If there's a search query, show the search results; otherwise, show the regular options
                if !searchText.isEmpty {
                    Section(header: Text("Search Results")) {
                        if viewModel.searchResults.isEmpty {
                            Text("No Results Found")
                            // This spacer is added in no results case as the view comes to center of the screen when there were no results found in search.
                            Spacer()
                        } else {
                            MovieDetailView(viewModel: viewModel, movies: viewModel.searchResults)
                        }
                    }
                } else {
                    Section {
                        // TODO: Cricbuzz interviewer question
                        //                        TabView(selection: $selectedTab) {
                        //                            ForEach(0..<items.count, id: \.self) { index in
                        //                                CardView(item: items[index])
                        //                            }
                        //                        }
                        //                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                        VStack(spacing: 8) {
                            HStack(spacing: 8) {
                                CategoryTextView(category: "Year", selectedCategory: $selectedCategory)
                                CategoryTextView(category: "Genre", selectedCategory: $selectedCategory)
                            }
                            HStack(spacing: 8) {
                                CategoryTextView(category: "Directors", selectedCategory: $selectedCategory)
                                CategoryTextView(category: "Actors", selectedCategory: $selectedCategory)
                            }
                            NavigationLink {
                                MovieDetailView(viewModel: viewModel, movies: viewModel.movies)
                            } label: {
                                Text("All Movies")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.vertical, 12)
                                    .padding(.horizontal, 16)
                                    .frame(maxWidth: .infinity)
                                    .background(LinearGradient(colors:  self.selectedCategory ==  "All Movies" ? selectedGradient :currentGradient, startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .cornerRadius(16)
                            }
                        }
                        .padding(.horizontal, 16)
                        
                    } header: {
                        Text("Categories")
                    }
                    
                    List {
                        ForEach(categories, id: \.self) { category in
                            Section {
                                if let category = selectedCategory {
                                        ForEach(viewModel.getSublist(category: category), id: \.self) { item in
                                            NavigationLink(
                                                destination: MovieDetailView(
                                                    viewModel: viewModel, movies: viewModel.getMovies(category: category, filter: item))) {
                                                        Text(item)
                                                    }
                                        }
                                }

                            }
                        header: {
                           Text(category)
                                .onTapGesture {
                                    selectedCategory = category
                                }
                        }
                        }
                    }
                    
                    //                    .listStyle(InsetGroupedListStyle())
//                    List {
//                        if let category = selectedCategory {
//                            Section(header: Text("Sublist for \(category)")) {
//                                ForEach(viewModel.getSublist(category: category), id: \.self) { item in
//                                    NavigationLink(
//                                        destination: MovieDetailView(
//                                            movies: viewModel.getMovies(category: category, filter: item))) {
//                                                Text(item)
//                                            }
//                                }
//                            }
//                        }
//                    }
                }
            }
        }
    }
}


struct CategoryRowView: View {
    let category: String
    @Binding var selectedCategory: String? // Binding to track the selected category
    @ObservedObject var viewModel: MoviesViewModel

    var body: some View {
            Section {
                ForEach(viewModel.getSublist(category: category), id: \.self) { item in
                    NavigationLink(
                        destination:  MovieDetailView(
                            viewModel: viewModel, movies: viewModel.getMovies(category: category, filter: item))                ) {
                                Text(item)
                            }
                }
            } header: {
                Text(category)
                    .onTapGesture {
                        if selectedCategory == category {
                            selectedCategory = nil // Collapse the category if it's already open
                        } else {
                            selectedCategory = category // Expand the category if it's not selected
                        }
                    }
            }
    }
}
