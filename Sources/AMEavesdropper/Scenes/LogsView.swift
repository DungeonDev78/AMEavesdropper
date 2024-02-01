//
//  LogsView.swift
//
//  Created by Alessandro Manilii on 29/01/24.
//

import SwiftUI

struct LogsView: View {
    
    enum ExportOrder {
        case ascending
        case descending
    }
    
    @Environment(\.colorScheme) private var colorScheme
    
    @State var logs: [LogModel]
    @State private var selectedLogs: [LogModel] = [LogModel]()
    @State var canShowPanel = false
    @State var canShowSearch = false
    @State private var exportOrder = ExportOrder.descending
    @State private var searchText = ""
    
    private let orderImgFilename = "arrow.up.arrow.down"
    private let exportImgFilename = "square.and.arrow.up"
    
    var searchImage: Image {
        canShowSearch ?
        Image(systemName: "minus.magnifyingglass") :
        Image(systemName: "plus.magnifyingglass")
    }
    
    var shownLogs: [LogModel] {
        if searchText.isEmpty {
            return logs
        } else {
            return logs.filter { $0.message?.localizedCaseInsensitiveContains(searchText) ?? false }
        }
    }
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                VStack(spacing: 0) {
                    // Search are
                    if canShowSearch {
                       SearchView(searchText: $searchText)
                            .frame(height: 70)
                    }
                    
                    ScrollView {
                        VStack(spacing: 0) {
  
                            ForEach(shownLogs) { log in
                                // Log cell
                                ZStack {
                                    bgColor(log: log)
                                    VStack {
                                        AttributedLabel(
                                            text: log.message ?? "---",
                                            searchText: searchText)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(8)
                                        
                                        Divider()
                                    }
                                    
                                    Color.black.opacity(0.001)
                                        .onTapGesture {
                                            toggle(log: log)
                                        }
                                }
                            }
                        }
                        
                        // Bottom Spacer
                        Color.clear
                            .frame(height: 100)
                    }
                }
               
                
                VStack {
                    Spacer()
                    // Selected logs view
                    SelectedLogsView(selectedLogs: $selectedLogs) {
                        updatePanelStatus()
                    }
                    .edgesIgnoringSafeArea(.all)
                    .frame(height: 80)
                    .offset(y: canShowPanel ? 0 : 200)
                }
            }
            // Navigation bar configs
            .navigationBarTitle("Log List", displayMode: .inline)
            .navigationBarItems(
                trailing:
                    // Button Share
                    Button(action: {
                        exportLogs()
                    }, label: {
                        Image(systemName: exportImgFilename)
                    })
            )
            .navigationBarItems(
                leading:
                    HStack {
                        // Button Sort
                        Button(action: {
                            updateLogOrder()
                        }, label: {
                            Image(systemName: orderImgFilename)
                        })
                        // Button Search
                        Button(action: {
                            withAnimation {
                                canShowSearch.toggle()
                                searchText = ""
                            }
                        }, label: {
                            searchImage
                        })
                    }
                    
            )
        }
    }
}

// MARK: - Private
private extension LogsView {
    
    func toggle(log: LogModel) {
        if let index = selectedLogs.firstIndex(where: { $0.id == log.id }) {
            selectedLogs.remove(at: index)
        } else {
            selectedLogs.append(log)
        }
        
        updatePanelStatus()
    }
    
    func bgColor(log: LogModel) -> Color {
        if selectedLogs.contains(where: { $0.id == log .id }) {
            return .green.opacity(0.3)
        } else {
            return colorScheme == .dark ? .white.opacity(0.1) : .white
        }
    }
    
    func updatePanelStatus() {
        withAnimation {
            canShowPanel = !selectedLogs.isEmpty
        }
    }
    
    func updateLogOrder() {
        
        switch exportOrder {
        case .ascending:
            exportOrder = .descending
            
        case .descending:
            exportOrder = .ascending
        }
        
        order(logs: shownLogs)
    }
    
    func exportLogs() {
        
        let items: [String]
        
        if !selectedLogs.isEmpty {
            order(logs: selectedLogs)
            items = [EavesdropperManager.shared.createTextualLog(for: selectedLogs)]
        } else {
            items = [EavesdropperManager.shared.createTextualLog(for: shownLogs)]
        }
                
        let ac = UIActivityViewController(
            activityItems: items, applicationActivities: nil
        )
        UIViewController.topMostViewController()?.present(ac, animated: true)
    }
    
    func order(logs: [LogModel]) {
        switch exportOrder {
        case .ascending:
            self.logs.sort { $0.date ?? Date() < $1.date ?? Date()}
            
        case .descending:
            self.logs.sort { $0.date ?? Date() > $1.date ?? Date()}
        }
    }
}

// MARK: - Static
extension LogsView {
    
    static func present() {
        let topVC = UIViewController.topMostViewController()
        let swiftUIView = LogsView(logs: EavesdropperManager.shared.getLogs())
        let viewCtrl = UIHostingController(rootView: swiftUIView)
        
        topVC?.present(viewCtrl, animated: true)
    }
}

struct LogsView_Previews: PreviewProvider {
    static var previews: some View {
        LogsView(logs: LogModel.examples)
    }
}
