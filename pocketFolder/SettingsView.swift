//
//  SettingsView.swift
//  pocketFolder
//
//  Created by @AwMan3703 (GitHub) on 30/10/24.
//

import SwiftUI

struct SettingsView: View {
    @State private var showFileImporter = false
    @State private var fileImporterFailed = false
    @State private var fileImporterErrorMessage: String = ""
    
    var body: some View {
        Section("File access") {
            Button {
                showFileImporter = true
            } label: {
                Label("Select a folder", systemImage: "folder.badge.plus")
            }
            .fileImporter(isPresented: $showFileImporter, allowedContentTypes: [.folder]) { result in
                switch result {
                case .success(let url):
                    let path = url.path
                    print("Granted access to \(path)")
                    break
                case .failure(let err):
                    fileImporterFailed = true
                    fileImporterErrorMessage = err.localizedDescription
                    break
                }
            }
            .alert(isPresented: $fileImporterFailed) {
                Alert(title: Text("Folder selection failed"), message: Text(fileImporterErrorMessage))
            }
        }
        .padding()
    }
}

#Preview {
    SettingsView()
}
