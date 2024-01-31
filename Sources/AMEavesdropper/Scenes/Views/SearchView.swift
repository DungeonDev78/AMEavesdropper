//
//  SearchView.swift
//
//
//  Created by Alessandro Manilii on 31/01/24.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var searchText: String

    var body: some View {
        ZStack {
            Color.secondary.opacity(0.2)
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
