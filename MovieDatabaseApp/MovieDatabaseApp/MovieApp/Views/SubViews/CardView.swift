//
//  CardView.swift
//  MovieDatabaseApp
//
//  Created by Nikhil Srikuramdasu on 21/10/23.
//

import SwiftUI

/// A view for displaying a card with an image as its background.
struct CardView: View {
    /// The item to be displayed in the card.
    private let item: String
    /// Initialize the CardView with an item.
    ///
    /// - Parameter item: The item to be displayed in the card.
    init(item: String) {
        self.item = item
    }
    
    var body: some View {
        ZStack {
            // Background image of the card.
            Image("Background")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 200)
                .padding(10)
                .cornerRadius(16)
        }
    }
}
