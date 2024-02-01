//
//  SearchView.swift
//
//
//  Created by Alessandro Manilii on 31/01/24.
//

import SwiftUI

struct SearchView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    @Binding var searchText: String
    
    var bgColorView: Color {
        
        Color.secondary.opacity(colorScheme == .dark ? 0.3 : 0.2)
    }

    var body: some View {
        ZStack {
            bgColorView
            ZStack(alignment: .trailing) {
                TextField("Search log", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                    .onTapGesture {
                        searchText = ""
                    }
            }
            .padding()
        }
    }
}

#Preview {
    SearchView(searchText: .constant("Log me"))
}
