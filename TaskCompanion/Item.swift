//
//  Item.swift
//  TaskCompanion
//
//  Created by Neal Archival on 8/30/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
