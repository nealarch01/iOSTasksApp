//
//  AddItemSheetView.swift
//  TaskCompanion
//
//  Created by Neal Archival on 8/31/24.
//

import SwiftUI

struct AddItemSheetView: View {
    // Form Data
    @State private var title = ""
    @State private var details = ""
    
    // UI
    @State private var showAlert = false

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationView {
            VStack {
                Group {
                    TCTextField(text: $title, header: "Title")
                    TCTextField(text: $details, header: "Details")
                }
                .padding(.vertical, 4)
                
                Spacer()
                
                Button(action: createNewItem) {
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
                    Button("Cancel", action: {
                        dismiss()
                    })
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("New Task")
            .alert(Text("Create failed"), isPresented: $showAlert) {
                Button("Ok") {}
            } message: {
                Text("An error occurred creating a new task.")
            }
        }
    }
}

// MARK: Methods

extension AddItemSheetView {
    private func createNewItem() {
        let dataHandler = DataHandler(modelContainer: modelContext.container)
        let newItem = Item(title: self.title, details: self.details)
        Task { @MainActor in
            let success = await dataHandler.addNewItem(newItem)
            if !success {
                showAlert = true
            } else {
                dismiss()
            }
        }
    }
}

#Preview {
    @Previewable let dataHandler = DataHandlerProvider.createForPreviews()
    @Previewable @State var sheetPresented = true
    
    VStack {
        Button("Toggle Sheet") {
            sheetPresented.toggle()
        }
    }
    .sheet(isPresented: $sheetPresented) {
        AddItemSheetView()
    }
    .modelContainer(ModelContainerProvider.createForPreviews())
}
