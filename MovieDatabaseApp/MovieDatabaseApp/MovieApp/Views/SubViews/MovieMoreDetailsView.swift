//
//  MovieMoreDetailsView.swift
//  MovieDatabaseApp
//
//  Created by Nikhil Srikuramdasu on 21/10/23.
//

import SwiftUI

struct MovieMoreDetailsView: View {
    @ObservedObject var viewModel: MoviesViewModel
    let movie: Movie // A movie object to display its details.
    let screenWidth: CGFloat = UIScreen.main.bounds.width * 0.30 // Calculate a width based on the screen size.
    let screenHeight: CGFloat = UIScreen.main.bounds.height * 0.40 // Calculate a height based on the screen size.
    @State private var currentRatingIndex: Int = 0 // A state variable to track the selected rating source index.    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ScrollView(.vertical) {
                HStack {
                    // Display the movie poster with an asynchronous image loading.
                    AsyncImage(url: URL(string: movie.poster ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, maxHeight: screenHeight)
                            .cornerRadius(16)
                    } placeholder: {
                        ProgressView()
                    }
                }
                Spacer()
                
                // Display various movie details using DetailSubView.
                DetailSubView(name: "Title", description: movie.title)
                DetailSubView(name: "Plot", description: movie.plot ?? "")
                DetailSubView(name: "Cast & Crew", description: movie.actors ?? "")
                DetailSubView(name: "Released Date", description: movie.released ?? "")
                DetailSubView(name: "Genre", description: movie.genre ?? "")
                
                // Allow the user to pick a rating source (Imdb, Rotten Tomatoes, or Metacritic).                    
                    Picker("Ratings", selection: $currentRatingIndex) {
                        Text("Imdb").tag(0)
                        Text("Rotten Tomatoes").tag(1)
                        Text("Metacritic").tag(2)
                    }
                    .pickerStyle(.segmented)
                    
                    // Display the movie's rating based on the selected source.
                    DetailSubView(name: "Rating", description: getMovieRating())
                    
                    // Display a custom rating view based on the source (IMDb in this case).
                    if movie.ratings?.count ?? 0 > 0 {
                        RatingView(rating: viewModel.getAverageRating(ratings: movie.ratings ?? [], title: movie.title ) / 2 , maxRating: 5)
                    }
                }
            }
            .padding(.horizontal, 16)
            .navigationTitle("Movie Details") // Set the navigation title.
        }
    }
    
    extension MovieMoreDetailsView {
        // Function to get the movie's rating based on the selected source.
        func getMovieRating() -> String {
            if currentRatingIndex < movie.ratings?.count ?? 0 {
                if let currentRating = movie.ratings?[safe: currentRatingIndex] {
                    return currentRating.value ?? "No rating available"
                }
            }
            return "No rating available"
        }
    }
