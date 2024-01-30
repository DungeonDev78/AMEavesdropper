//
//  SelectedLogsView.swift
//
//  Created by Alessandro Manilii on 29/01/24.
//

import SwiftUI

struct SelectedLogsView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    @Binding var selectedLogs: [LogModel]
    var onUpdate: () -> Void
    
    private var panelColor: Color {
        colorScheme == .dark ? .black.opacity(0.7) : .gray.opacity(0.05)
    }
    
    var body: some View {
        
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                    .shadow(radius: 10)
                    
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(panelColor)
            }
            
            
            HStack {
                Text("Selected logs: \(selectedLogs.count)")
                Spacer()
                Button {
                    selectedLogs = []
                    onUpdate()
                } label: {
                    Image(systemName: "trash")
                        .font(.title)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    SelectedLogsView(selectedLogs: .constant([])) {
        print("ok")
    }
}
