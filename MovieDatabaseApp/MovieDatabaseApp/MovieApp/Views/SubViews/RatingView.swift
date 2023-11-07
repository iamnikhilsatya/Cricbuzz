//
//  RatingView.swift
//  MovieDatabaseApp
//
//  Created by Nikhil Srikuramdasu on 21/10/23.
//

import SwiftUI

struct RatingView: View {
    private let rating: CGFloat // The rating value to be displayed.
    private let maxRating: Int // The maximum rating possible.

    // Initialize the RatingView with a rating and maximum rating.
    init(rating: CGFloat, maxRating: Int) {
        self.rating = rating
        self.maxRating = maxRating
    }

    var body: some View {
        // Create a horizontal stack of stars
        let stars = HStack(spacing: 0) {
            ForEach(0..<maxRating, id: \.self) { _ in
                Image(systemName: "star.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            }
        }

        // Overlay the stars with a colored bar to represent the rating
        stars.overlay(
            GeometryReader { g in
                // Calculate the width of the colored bar based on the rating
                let width = rating / CGFloat(maxRating) * g.size.width
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: width)
                        .foregroundColor(.yellow) // Set the color of the rating bar to yellow
                }
            }
            .mask(stars) // Use stars as a mask to show the colored bar only within the star boundaries
        )
        .foregroundColor(.gray) // Set the star color to gray
    }
}
