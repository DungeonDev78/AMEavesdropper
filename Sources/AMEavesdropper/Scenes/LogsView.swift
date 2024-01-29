//
//  LogsView.swift
//
//  Created by Alessandro Manilii on 29/01/24.
//

import SwiftUI

struct LogsView: View {
    
    @State var logs: [LogModel]
    @State private var selectedLogs: [LogModel] = [LogModel]()
    @State var canShowPanel = false
    @Environment(\.colorScheme) private var colorScheme
    
    func bgColor(log: LogModel) -> Color {
        if selectedLogs.contains(where: { $0.id == log .id }) {
            return .green.opacity(0.3)
        } else {
            return colorScheme == .dark ? .white.opacity(0.1) : .white
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                    
                List(logs) { log in
                    Text(log.message ?? "---")
                        .font(.caption)
                        .listRowBackground(bgColor(log: log))
                        .onTapGesture {
                            toggle(log: log)
                        }
                    }
                if canShowPanel {
                    HStack {
                        Text("Selected count: \(selectedLogs.count)")
                        Spacer()
                        Button {
                            selectedLogs = []
                            checkPanelStatus()
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Log List", displayMode: .inline)
            .navigationBarItems(
                trailing:
                    Button(action: {
                        print("SHARE")
                    }, label: {
                        Image(systemName: "square.and.arrow.up")
                    })
            )
            .navigationBarItems(
                leading:
                    Button(action: {
                        print("SHARE")
                        logs.reverse()
                    }, label: {
                        Image(systemName: "arrow.up.arrow.down")
                    })
            )
        }
    }
    
    func toggle(log: LogModel) {
        if let index = selectedLogs.firstIndex(where: { $0.id == log.id }) {
            selectedLogs.remove(at: index)
        } else {
            selectedLogs.append(log)
        }
        
        checkPanelStatus()
    }
    
    func checkPanelStatus() {
        withAnimation {
            canShowPanel = !selectedLogs.isEmpty
        }
    }
}

struct LogsView_Previews: PreviewProvider {
    static var previews: some View {
        LogsView(logs: LogModel.examples)
    }
}
