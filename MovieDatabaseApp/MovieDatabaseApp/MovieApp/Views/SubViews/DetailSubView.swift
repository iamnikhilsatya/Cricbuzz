//
//  DetailSubView.swift
//  MovieDatabaseApp
//
//  Created by Nikhil Srikuramdasu on 21/10/23.
//

import SwiftUI

struct DetailSubView: View {
    private let name: String // The name or label of the detail.
    private let description: String // The description or value of the detail.

    // Initialize the DetailSubView with a name and description.
    init(name: String, description: String) {
        self.name = name
        self.description = description
    }

    var body: some View {
        HStack(alignment: .top ,spacing: 4) {
            Text("\(name): ")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .lineLimit(0) // Allow the text to wrap if needed.
            Text(description)
                .font(.title3)
                .foregroundColor(Color.black)
                .multilineTextAlignment(.leading) // Allow the text to be left-aligned and wrap if needed.
            Spacer() // Add spacing to the right to separate the details.
        }
    }
}
