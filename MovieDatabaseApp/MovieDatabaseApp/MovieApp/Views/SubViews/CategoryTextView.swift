//
//  ReusableButton.swift
//  MovieDatabaseApp
//
//  Created by Nikhil Srikuramdasu on 21/10/23.
//

import SwiftUI

struct CategoryTextView: View {
    private let category: String // The text to be displayed for the category.
    @Binding var selectedCategory: String? // A binding to the selected category.
    private let currentGradient: [Color] = [Color("backgroundColor"), Color("grey")] // Gradient colors for the unselected state.
    private let selectedGradient: [Color] = [Color("majenta"), Color("backgroundColor")] // Gradient colors for the selected state.

    // Initialize the CategoryTextView with a category and a binding to the selected category.
    init(category: String, selectedCategory: Binding<String?>) {
        self.category = category
        self._selectedCategory = selectedCategory
    }

    var body: some View {
        Text(category)
            .font(.subheadline)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
            .background(LinearGradient(colors: self.selectedCategory ==  category ? selectedGradient : currentGradient, startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(16) // Rounded corners for the background.
            .onTapGesture {
                self.selectedCategory = category // Update the selected category when tapped.
            }
    }
}
