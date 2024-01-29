//
//  LogsView.swift
//
//  Created by Alessandro Manilii on 29/01/24.
//

import SwiftUI
import Combine

struct LogsView: View {
    
    @State var logs: [LogModel]
    @State private var selectedLogs: [LogModel] = [LogModel]()
    @State var canShowPanel = false
    @Environment(\.colorScheme) private var colorScheme
    
    @State var cancellables = Set<AnyCancellable>()
    
    func bgColor(log: LogModel) -> Color {
        if selectedLogs.contains(where: { $0.id == log .id }) {
            return .green.opacity(0.3)
        } else {
            return colorScheme == .dark ? .white.opacity(0.1) : .white
        }
    }
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(logs) { log in
                            ZStack {
                                bgColor(log: log)
                                VStack {
                                    Text(log.message ?? "---")
                                        .font(.caption)
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
        
        updatePanelStatus()
    }
    
    func updatePanelStatus() {
        withAnimation {
            canShowPanel = !selectedLogs.isEmpty
        }
    }
}

extension LogsView {
    
    static func present() {
        let topVC = UIViewController.topMostViewController()
        let swiftUIView = LogsView(logs: Eavesdropper.getLogs())
        let viewCtrl = UIHostingController(rootView: swiftUIView)
        
        topVC?.present(viewCtrl, animated: true)
    }
}

struct LogsView_Previews: PreviewProvider {
    static var previews: some View {
        LogsView(logs: LogModel.examples)
    }
}
