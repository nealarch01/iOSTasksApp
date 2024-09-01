//
//  ItemInfoView.swift
//  TaskCompanion
//
//  Created by Neal Archival on 8/31/24.
//

import SwiftUI

struct ItemInfoView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(NavigationManager.self) private var navigationManager
    @Environment(\.modelContext) private var modelContext
    
    @State private var editSheetPresented = false
    
    var item: Item
    var itemStatus: ItemStatus
    
    var body: some View {
        List {
            Section {
                LabeledContent("Title", value: item.title)
                VStack(alignment: .leading) {
                    Text("Description")
                    Text(item.details)
                        .foregroundStyle(Color.gray)
                }
                LabeledContent("Status", value: item.status.title)
                LabeledContent("Created At", value: formatTimeIntervalToDate(item.createdAt))
            } header: {
                Text("Task Details")
            }
            
            Section {
                switch itemStatus {
                case .notStarted:
                    Button(action: {
                        updateTaskStatus(to: .inProgress)
                    }) {
                        Text("Start Task")
                    }
                    
                case .inProgress:
                    Button(action: {
                        updateTaskStatus(to: .notStarted)
                    }) {
                        Text("Move to To Do")
                    }
                    
                    Button(action: {
                        updateTaskStatus(to: .inProgress)
                    }) {
                        Text("Done")
                    }
                    
                case .complete:
                    Button(action: {
                        updateTaskStatus(to: .notStarted)
                    }) {
                        Text("Move to To Do")
                    }
                    
                    Button(action: {
                        updateTaskStatus(to: .inProgress)
                    }) {
                        Text("Move to In Progress")
                    }
                }
            } header: {
                Text("Actions")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Edit") {
                    editSheetPresented = true
                }
            }
        }
        .sheet(isPresented: $editSheetPresented) {
            EditItemSheetView(item: item)
        }
    }
}

// MARK: Methods

extension ItemInfoView {
    private func updateTaskStatus(to status: ItemStatus) {
        let dataHandler = DataHandler(modelContainer: modelContext.container)
        Task { @MainActor in
            let success = await dataHandler.updateItemStatus(item: item, to: status)
            if success {
                dismiss()
            }
        }
    }
}

extension ItemInfoView {
    private func formatTimeIntervalToDate(_ interval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: interval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: date)
    }
}

#Preview {
    ItemInfoView(
        item: Item(
            title: "Movie tickets 🍿",
            details: "Tickets for Despicable Me 4!"
        ),
        itemStatus: .notStarted
    )
    .environment(NavigationManager())
}
