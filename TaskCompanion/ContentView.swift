//
//  ContentView.swift
//  TaskCompanion
//
//  Created by Neal Archival on 8/30/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(NavigationManager.self) private var navigationManager
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item] // Query all items
    
    private var itemsNotStarted: [Item] { items.filter { $0.status == .notStarted } }
    private var itemsInProgress: [Item] { items.filter { $0.status == .inProgress } }
    private var itemsCompleted: [Item] { items.filter { $0.status == .complete } }

    var body: some View {
        @Bindable var navigationManager = navigationManager
        
        TabView(selection: $navigationManager.selectedTab) {
            Tab("To Do", systemImage: "checklist.unchecked", value: .notStarted) {
                TodoStack(items: itemsNotStarted)
            }
            .badge(itemsNotStarted.count)
            
            Tab("In Progress", systemImage: "clock", value: .inProgress) {
                InProgressStack(items: itemsInProgress)
            }
            .badge(itemsInProgress.count)
            
            Tab("Done", systemImage: "checklist.checked", value: .completed) {
                CompletedStack(items: itemsCompleted)
            }
        }
        .sheet(isPresented: $navigationManager.addItemSheetIsPresented) {
            VStack {
                AddItemSheetView()
            }
        }
    }
}

#Preview {
    let previewsModelContainer = ModelContainerProvider.createForPreviews(insertMockData: true)
    
    return ContentView()
        .environment(NavigationManager(selectedTab: .notStarted))
        .modelContainer(previewsModelContainer)
}
