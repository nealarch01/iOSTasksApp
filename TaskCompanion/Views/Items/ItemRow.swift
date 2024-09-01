//
//  ItemRow.swift
//  TaskCompanion
//
//  Created by Neal Archival on 8/31/24.
//

import SwiftUI

struct ItemRow: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var showConfirmDeleteDialog = false
    
    var item: Item
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(item.title)
            
            Text(item.details)
                .font(.subheadline)
                .lineLimit(2)
                .foregroundStyle(Color.gray)
        }
        .swipeActions(edge: .trailing) {
            Button(action: { showConfirmDeleteDialog = true }) {
                Image(systemName: "trash")
            }
            .tint(Color.red)
        }
        .confirmationDialog("Delete item?", isPresented: $showConfirmDeleteDialog) {
            Button("Delete item?", role: .destructive, action: deleteItem)
        }
    }
    
    private func deleteItem() {
        let dataHandler = DataHandler(modelContainer: modelContext.container)
        Task {
            await dataHandler.deleteItem(withID: item.id)
        }
    }
}

#Preview {
    List {
        ItemRow(item: Item(title: "Item 1", details: ""))
    }
    .modelContainer(ModelContainerProvider.createForPreviews())
}
