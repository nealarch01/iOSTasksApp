//
//  TaskCompanionApp.swift
//  TaskCompanion
//
//  Created by Neal Archival on 8/30/24.
//

import SwiftUI
import SwiftData
import AppIntents

@main
struct TaskCompanionApp: App {
    let navigationManager: NavigationManager
    let sharedModelContainer: ModelContainer

    init() {
        let navigationManager = NavigationManager()
        let sharedModelContainer = ModelContainerProvider.createShared()
        
        // Add the dependencies.
        AppDependencyManager.shared.add(dependency: navigationManager)
        AppDependencyManager.shared.add(dependency: sharedModelContainer)
        
        // Initialize the properties.
        self.navigationManager = navigationManager
        self.sharedModelContainer = sharedModelContainer
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(navigationManager)
        }
        .modelContainer(sharedModelContainer)
    }
}
