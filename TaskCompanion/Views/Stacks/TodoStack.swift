//
//  TodoStack.swift
//  TaskCompanion
//
//  Created by Neal Archival on 8/31/24.
//

import SwiftUI
import SwiftData

struct TodoStack: View {
    @Environment(NavigationManager.self) private var navigationManager
    @Environment(\.modelContext) private var modelContext
    
    var items: [Item]

    var body: some View {
        @Bindable var navigationManager = navigationManager
        
        NavigationStack(path: $navigationManager.notStartedPath) {
            List {
                ForEach(items, id: \.id) { item in
                    NavigationLink(value: item) {
                        ItemRow(item: item)
                    }
                }
            }
            .itemNavigation(status: .notStarted)
            .navigationTitle("To Do")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: openNewItemSheet) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    private func openNewItemSheet() {
        navigationManager.openAddItemSheet()
    }
    
    private func debug() {
        print("hasChanges: \(modelContext.hasChanges)")
    }
}

#Preview {
    TodoStack(items: [])
}
