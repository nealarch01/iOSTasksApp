//
//  ShortcutsProvider.swift
//  TaskCompanion
//
//  Created by Neal Archival on 9/1/24.
//

import AppIntents
import SwiftUI

struct TaskCompanionShortcutsProvider: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: CreateTaskIntent(),
            phrases: [
                "Create \(.applicationName) item"
            ],
            shortTitle: "Create",
            systemImageName: "plus"
        )
    }
}
