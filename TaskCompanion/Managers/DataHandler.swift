//
//  DataHandler.swift
//  TaskCompanion
//
//  Created by Neal Archival on 8/30/24.
//

import Foundation
import SwiftData
import SwiftUI

// MARK: DataHandler

/// Object that is responsible for making changes to the model container.
/// To use this object, a reference to a `ModelContainer` will be needed.
///
/// **Usage example:**
/// ```swift
/// let dataHandler = DataHandler(modelContainer: modelContainer)
/// dataHandler.addNewItem(myNewItem)
/// ```
///
@ModelActor
actor DataHandler {
    
    // MARK: Create
    
    @discardableResult
    func addNewItem(_ item: Item) -> Bool {
        modelContext.insert(item)
        return saveModelContext()
    }
    
    // MARK: Delete
    
    func deleteItem(withID id: UUID) -> Bool {
        guard let item = fetchItem(withID: id) else { return false }
        modelContext.delete(item)
        return saveModelContext()
    }
    
    // MARK: Update
    
    func updateItemStatus(item: Item, to status: ItemStatus) -> Bool {
        item.status = status
        return saveModelContext()
    }
    
    @discardableResult
    func updateItemInfo(item: Item, newTitle: String? = nil, newDetails: String? = nil) -> Bool {
        if let newTitle {
            item.title = newTitle
        }
        if let newDetails {
            item.details = newDetails
        }
        return saveModelContext()
    }
    
    // MARK: Read
    
    func fetchItem(withID id: UUID) -> Item? {
        let fetchDescriptor = FetchDescriptor<Item>(
            predicate: #Predicate { $0.id == id }
        )
        let items = try? modelContext.fetch(fetchDescriptor)
        return items?.first
    }
    
    // MARK: Save
    
    @discardableResult
    private func saveModelContext() -> Bool {
        do {
            try modelContext.save()
            return true
        } catch {
            return false
        }
    }
}

struct DataHandlerProvider {
    static func createForPreviews(
        modelContainer: ModelContainer = ModelContainerProvider.createForPreviews()
    ) -> DataHandler {
        return DataHandler(modelContainer: modelContainer)
    }
}

private struct DataHandlerKey: EnvironmentKey {
    static let defaultValue: DataHandler? = nil
}

extension EnvironmentValues {
    var dataHandler: DataHandler? {
        get { self[DataHandlerKey.self] }
        set { self[DataHandlerKey.self] = newValue }
    }
}
