//
//  MovieDetailView.swift
//  MovieDatabaseApp
//
//  Created by Nikhil Srikuramdasu on 21/10/23.
//

import SwiftUI

/// A view for displaying a list of movies with basic details.
struct MovieDetailView: View {
    
    @ObservedObject var viewModel: MoviesViewModel
    
    @State var selectedType: String = "Year"
    /// An array of movies to display.
    let movies: [Movie]
    /// The width of the screen, calculated as a percentage of the main screen's width.
    let screenWidth: CGFloat = UIScreen.main.bounds.width * 0.30
    /// The height of the screen, calculated as a percentage of the main screen's height.
    let screenHeight: CGFloat = UIScreen.main.bounds.height * 0.40
    
    @State private var selectedFilter = "Alphabet"
    let filters = ["Alphabet", "Rating", "Year"]
    
    /// Initialize the MovieDetailView with a list of movies.
    ///
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 4) {
                    Spacer()
                    Text("Filters")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                        .lineLimit(0)
                    
                    Picker("Appearance", selection: $selectedFilter) {
                        ForEach(filters, id: \.self) {
                            Text($0)
                                .foregroundStyle(.black)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 10)
                        }
                    }
                }
                
                ForEach(viewModel.filteredMovies(filterList: movies, selectedFilter: self.selectedFilter), id: \.id) { movie in
                    NavigationLink {
                        MovieMoreDetailsView(viewModel: viewModel, movie: movie)
                    } label: {
                        HStack(spacing: 4) {
                            HStack {
                                AsyncImage(url: URL(string: movie.poster ?? "")) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(maxWidth: screenWidth, maxHeight: .infinity)
                                        .cornerRadius(16)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                            VStack(alignment: .leading, spacing: 2) {
                                Text(movie.title)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.black)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                                HStack(alignment: .top, spacing: 4) {
                                    Text("Language: ")
                                        .font(.title3)
                                        .foregroundColor(Color.black)
                                        .lineLimit(0)
                                    Text(movie.language ?? "")
                                        .font(.title3)
                                        .foregroundColor(Color.black)
                                        .multilineTextAlignment(.leading)
                                }
                                Spacer()
                                HStack(alignment: .top, spacing: 4) {
                                    Text("Released: ")
                                        .font(.title3)
                                        .foregroundColor(Color.black)
                                        .lineLimit(0)
                                    Text(movie.released ?? "")
                                        .font(.title3)
                                        .foregroundColor(Color.black)
                                        .multilineTextAlignment(.leading)
                                }
                                Spacer()
                                Text("Year: \(movie.year ?? "")")
                                    .font(.title3)
                                    .foregroundColor(Color.black)
                                    .lineLimit(0)
                            }
                            .padding(.vertical, 4)
                            Spacer()
                        }
                        .padding(.vertical, 6)
                        .padding(.horizontal, 12)
                        .frame(maxHeight: screenHeight, alignment: .top)
                        .background(RoundedRectangle(cornerRadius: 6)
                            .stroke(LinearGradient(colors: [Color("backgroundColor"), Color("grey")], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1.5))
                        .cornerRadius(6)
                        .padding(.horizontal, 6)
                    }
                }
                .navigationBarTitle("")
            }
        }
    }
}
