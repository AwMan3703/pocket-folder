//
//  SettingsView.swift
//  pocketFolder
//
//  Created by Daniele Brambilla on 30/10/24.
//

import SwiftUI

struct SettingsView: View {
    @State private var showFileImporter = false
    
    var body: some View {
        Section("File access") {
            Button {
                showFileImporter = true
            } label: {
                Label("Select a folder", systemImage: "folder.badge.plus")
            }
            .fileImporter(isPresented: $showFileImporter, allowedContentTypes: [.folder]) { result in
            }
        }
        .padding()
    }
}

#Preview {
    SettingsView()
}
