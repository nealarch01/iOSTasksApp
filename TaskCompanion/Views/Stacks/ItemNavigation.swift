//
//  ItemNavigation.swift
//  TaskCompanion
//
//  Created by Neal Archival on 9/3/24.
//

import SwiftUI

extension View {
    @ViewBuilder
    func itemNavigation(status: ItemStatus) -> some View {
        self.navigationDestination(for: Item.self) { item in
            ItemInfoView(item: item, itemStatus: status)
        }
    }
}
