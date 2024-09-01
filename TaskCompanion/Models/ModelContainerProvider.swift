//
//  ModelContainerProvider.swift
//  TaskCompanion
//
//  Created by Neal Archival on 8/31/24.
//

import SwiftData
import Foundation

struct ModelContainerProvider {
    static func createShared(insertMockData: Bool = false) -> ModelContainer {
        let schema = Schema([Item.self])
        let modelConfiguration = ModelConfiguration(isStoredInMemoryOnly: false)
        do {
            let modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            if insertMockData {
                let dataHandler = DataHandler(modelContainer: modelContainer)
                [
                    Item(title: "Exercise 🏋️", details: "Full-body workout @ 6PM"),
                    Item(title: "Water plants 🌱", details: ""),
                    Item(title: "Meal Prep 🍳", details: "Breakfast for Monday to Wednesday")
                ].forEach { item in
                    Task {
                        await dataHandler.addNewItem(item)
                    }
                }
            }
            return modelContainer
        } catch let error {
            fatalError("ModelContainerProvider.createSharedModelContainer: Failed to initialize. \(error.localizedDescription)")
        }
    }
    
    static func createForPreviews(insertMockData: Bool = true) -> ModelContainer {
        let schema = Schema([Item.self])
        let modelConfiguration = ModelConfiguration(isStoredInMemoryOnly: true)
        do {
            let modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            if insertMockData {
                let dataHandler = DataHandler(modelContainer: modelContainer)
                [
                    Item(title: "Exercise 🏋️", details: "Full-body workout @ 6PM"),
                    Item(title: "Water plants 🌱", details: ""),
                    Item(title: "Meal Prep 🍳", details: "Breakfast for Monday to Wednesday")
                ].forEach { item in
                    Task {
                        await dataHandler.addNewItem(item)
                    }
                }
            }
            return modelContainer
        } catch let error {
            fatalError("ModelContainerProvider.createPreviewsModelContainer: Failed to initialize. \(error.localizedDescription)")
        }
    }
}
