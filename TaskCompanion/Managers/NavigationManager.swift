//
//  NavigationManager.swift
//  TaskCompanion
//
//  Created by Neal Archival on 8/30/24.
//

import SwiftUI
import Observation

@MainActor @Observable
class NavigationManager {
    
    // MARK: Tab
    
    enum Tab: Int {
        case notStarted
        case inProgress
        case completed
    }
    
    // MARK: Properties
    
    // Tabs
    var selectedTab: Tab
    
    // Paths
    var notStartedPath: NavigationPath
    var inProgressPath: NavigationPath
    var completedPath: NavigationPath
    
    // Sheets
    var addItemSheetIsPresented: Bool
    
    var refreshFlag: Bool
    
    // MARK: Initializer
    
    init(
        selectedTab: Tab = .inProgress,
        notStartedPath: NavigationPath = NavigationPath(),
        inProgressPath: NavigationPath = NavigationPath(),
        completedPath: NavigationPath = NavigationPath()
    ) {
        self.selectedTab = .inProgress
        self.notStartedPath = notStartedPath
        self.inProgressPath = inProgressPath
        self.completedPath = completedPath
        self.addItemSheetIsPresented = false
        self.refreshFlag = false
    }
    
    func openItem(item: Item) {
        switch item.status {
        case .notStarted:
            notStartedPath = NavigationPath([item])
            
        case .inProgress:
            inProgressPath = NavigationPath([item])
            
        case .complete:
            completedPath = NavigationPath([item])
        }
    }
    
    func openAddItemSheet() {
        addItemSheetIsPresented = true
    }
}
