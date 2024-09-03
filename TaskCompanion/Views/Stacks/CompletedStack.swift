//
//  CompletedStack.swift
//  TaskCompanion
//
//  Created by Neal Archival on 8/31/24.
//

import SwiftUI

struct CompletedStack: View {
    @Environment(NavigationManager.self) private var navigationManager
    var items: [Item]
    
    var body: some View {
        @Bindable var navigationManager = navigationManager
        
        NavigationStack(path: $navigationManager.completedPath) {
            List {
                ForEach(items, id: \.id) { item in
                    NavigationLink(value: item) {
                        ItemRow(item: item)
                    }
                }
            }
            .itemNavigation(status: .complete)
            .navigationTitle("Done")
        }
    }
}
