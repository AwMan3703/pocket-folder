//
//  FolderManagerView.swift
//  pocketFolder
//
//  Created on 31/10/24.
//  
//
    

import SwiftUI

struct FolderManagerView: View {
    @EnvironmentObject var pocketFoldersManager: PocketFoldersManager
    @State private var showFileImporter = false
    @State private var fileImporterFailed = false
    @State private var fileImporterErrorMessage = ""
    @State private var selected = Set<PocketFolder.ID>()

    
    var body: some View {
        Text("Select folders to access from your pockets")
        
        VStack {
            Table(pocketFoldersManager.folders, selection: $selected) {
                TableColumn("Name", value: \.name)
                TableColumn("Path", value: \.path)
            }
            
            HStack {
                Button(action: {
                    showFileImporter = true
                }) { Image(systemName: "plus") }
                
                Button(role: .destructive, action: {
                    // REMOVE ITEM LOGIC
                    pocketFoldersManager.folders.removeAll(where: { item in
                        selected.contains(item.id)
                    })
                    selected.removeAll()
                }) { Image(systemName: "minus") }
                    .disabled(selected.isEmpty)
            }
            .fileImporter(isPresented: $showFileImporter, allowedContentTypes: [.directory, .folder]) { result in
                switch result {
                case .success(let url):
                    // ADD ITEM LOGIC
                    print("Granted access to \(url.path)")
                    if pocketFoldersManager.folders.contains(where: { item in
                        // If the path already exists, ignore it
                        item.path == url.path
                    }) { break }
                    pocketFoldersManager.folders.insert(PocketFolder(pathURL: url), at: 0)
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
    }
}

#Preview {
    FolderManagerView()
        .environmentObject(PocketFoldersManager())
}
