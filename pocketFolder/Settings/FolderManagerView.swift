//
//  FolderManagerView.swift
//  pocketFolder
//
//  Created on 31/10/24.
//  
//
    

import SwiftUI

struct FolderManagerView: View {
    @EnvironmentObject var dataProvider: DataProvider
    @State private var showFileImporter = false
    @State private var fileImporterFailed = false
    @State private var fileImporterErrorMessage = ""
    @State private var selected = Set<PocketFolder.ID>()

    
    var body: some View {
        Text("Select folders to access from your pockets")
        
        VStack {
            Table(dataProvider.paths, selection: $selected) {
                TableColumn("Name", value: \.name)
                TableColumn("Path", value: \.path)
            }
            .frame(height: 100)
            
            HStack {
                Button(action: {
                    showFileImporter = true
                }) { Image(systemName: "plus") }
                
                Button(role: .destructive, action: {
                    // REMOVE ITEM LOGIC
                    dataProvider.paths.removeAll(where: { item in
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
                    if dataProvider.paths.contains(where: { item in
                        // If the path already exists, ignore it
                        item.path == url.path
                    }) { break }
                    dataProvider.paths.insert(PocketFolder(pathURL: url), at: 0)
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
        .environmentObject(DataProvider())
}
