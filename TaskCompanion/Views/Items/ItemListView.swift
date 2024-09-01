//
//  ItemListView.swift
//  TaskCompanion
//
//  Created by Neal Archival on 8/30/24.
//

import SwiftUI

struct ItemListView: View {
    @Binding var navigationPath: NavigationPath
    var sectionTitle: String = ""
    var items: [Item]
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(items, id: \.id) { item in
                        itemRow(item)
                    }
                }
            }
            .navigationTitle(sectionTitle)
            .navigationDestination(for: Item.self) { item in
                VStack {
                    Text(item.title)
                }
            }
        }
    }
    
    @ViewBuilder
    private func itemRow(_ item: Item) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(item.title)
            
            Text(item.details)
                .font(.subheadline)
                .lineLimit(2)
                .foregroundStyle(Color.gray)
        }
        .swipeActions(edge: .trailing) {
            Button(action: {}) {
                Image(systemName: "trash")
            }
            .tint(Color.red)
        }
    }
}

#Preview {
    @Previewable @State var navigationManager = NavigationManager()
    
    ItemListView(
        navigationPath: $navigationManager.notStartedPath,
        sectionTitle: "To Do",
        items: [
            Item(title: "Exercise 🏋️", details: "Full-body workout @ 6PM"),
            Item(title: "Water plants 🌱", details: ""),
            Item(title: "Meal Prep 🍳", details: "Breakfast for Monday to Wednesday")
        ]
    )
}
