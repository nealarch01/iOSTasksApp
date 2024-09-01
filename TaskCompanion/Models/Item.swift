//
//  Item.swift
//  TaskCompanion
//
//  Created by Neal Archival on 8/30/24.
//

import Foundation
import SwiftData

// MARK: ItemStatus

enum ItemStatus: Int, Codable, CaseIterable, Identifiable {
    case notStarted = 0
    case inProgress = 1
    case complete = 2
    
    var title: String {
        switch self {
        case .notStarted:
            return "To Do"
        case .inProgress:
            return "In Progress"
        case .complete:
            return "Done"
        }
    }
    
    var id: Self { self }
}

// MARK: ItemProtocol

protocol ItemProtocol: Identifiable {
    var id: UUID  { get set }
    var title: String { get set }
    var details: String { get set }
    var status: ItemStatus { get set }
    var createdAt: TimeInterval { get set }
}

// MARK: Item

@Model
class Item: ItemProtocol {
    var id: UUID
    var title: String
    var details: String
    var status: ItemStatus
    var createdAt: TimeInterval
    
    init(
        title: String,
        details: String = "",
        status: ItemStatus = .notStarted,
        createdAt: TimeInterval = Date.now.timeIntervalSince1970
    ) {
        self.id = UUID()
        self.title = title
        self.details = details
        self.status = status
        self.createdAt = createdAt
    }
}
