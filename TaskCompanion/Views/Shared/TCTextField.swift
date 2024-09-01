//
//  TCTextField.swift
//  TaskCompanion
//
//  Created by Neal Archival on 8/31/24.
//

import SwiftUI

struct TCTextField: View {
    @FocusState private var focused
    
    @Binding var text: String
    var header: String = ""
    var placeholder: String = ""
    
    var textPrompt: Text {
        Text(placeholder)
    }
    
    var body: some View {
        VStack(spacing: 8) {
            if !header.isEmpty {
                Text(header)
                    .foregroundStyle(Color.black.opacity(0.8))
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 6)
            }
            
            TextField("", text: $text, prompt: placeholder.isEmpty ? nil : textPrompt)
                .focused($focused)
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(focused ? Color.gray : Color.gray.opacity(0.5), lineWidth: 1.5)
                }
        }
    }
}

#Preview {
    @Previewable @State var text: String = ""
    
    TCTextField(
        text: $text,
        header: "Title",
        placeholder: "Placeholder"
    )
    .padding(.horizontal)
}
