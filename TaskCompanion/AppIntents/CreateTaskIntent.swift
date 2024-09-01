//
//  CreateTaskIntent.swift
//  TaskCompanion
//
//  Created by Neal Archival on 9/1/24.
//

import Foundation
import AppIntents
import SwiftUI

struct CreateTaskIntent: AppIntent {
    static var title: LocalizedStringResource = "Create Task"
    static var description = IntentDescription("Create a task and add it to the To Do tab of the app.")
    
    @AppDependency private var navigationManager: NavigationManager
    
    static var openAppWhenRun = true
    
    @MainActor
    func perform() async throws -> some IntentResult {
        navigationManager.selectedTab = .notStarted
        navigationManager.addItemSheetIsPresented = true
        return .result()
    }
}
