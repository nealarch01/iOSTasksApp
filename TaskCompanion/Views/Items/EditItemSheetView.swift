//
//  EditItemSheetView.swift
//  TaskCompanion
//
//  Created by Neal Archival on 8/31/24.
//

import SwiftUI

struct EditItemSheetView: View {
    @Environment(NavigationManager.self) private var navigationManager
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    var item: Item
    
    @State private var title: String
    @State private var details: String
    
    @State private var showAlert = false
    
    init(item: Item) {
        self.item = item
        self._title = State(initialValue: item.title)
        self._details = State(initialValue: item.details)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Group {
                    TCTextField(text: $title, header: "Title")
                    TCTextField(text: $details, header: "Details")
                }
                .padding(.vertical, 4)
                
                Spacer()
                
                Button(action: editItem) {
                    Text("Done")
                        .foregroundStyle(Color.white)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.top)
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
            .navigationTitle("Edit Task")
            .navigationBarTitleDisplayMode(.inline)
            .alert(Text("Create failed"), isPresented: $showAlert) {
                Button("Ok") {}
            } message: {
                Text("An error occurred editting task.")
            }
        }
    }
}

// MARK: Methods

extension EditItemSheetView {
    private func editItem() {
        let dataHandler = DataHandler(modelContainer: modelContext.container)
        Task { @MainActor in
            let success = await dataHandler.updateItemInfo(
                item: item,
                newTitle: title,
                newDetails: details
            )
            if !success {
                showAlert = true
            } else {
                dismiss()
            }
        }
    }
}

#Preview {
    @Previewable @State var sheetPresented = true
    
    VStack {
        Button("Toggle sheet") {
            sheetPresented = true
        }
    }
    .sheet(isPresented: $sheetPresented) {
        EditItemSheetView(
            item: Item(
                title: "Movie Tickets 🍿",
                details: "Tickets for Despicable Me 4!"
            )
        )
    }
    .modelContainer(ModelContainerProvider.createForPreviews())
}
