//
//  InProgressStack.swift
//  TaskCompanion
//
//  Created by Neal Archival on 8/31/24.
//

import SwiftUI

struct InProgressStack: View {
    @Environment(NavigationManager.self) private var navigationManager
    var items: [Item]
    
    var body: some View {
        @Bindable var navigationManager = navigationManager
        
        NavigationStack(path: $navigationManager.inProgressPath) {
            List {
                ForEach(items, id: \.id) { item in
                    NavigationLink(value: item) {
                        ItemRow(item: item)
                    }
                }
            }
            .navigationTitle("In Progress")
        }
    }
}
