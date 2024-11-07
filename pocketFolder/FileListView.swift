//
//  FileListView.swift
//  pocketFolder
//
//  Created by @AwMan3703 (GitHub) on 30/10/24.
//

import SwiftUI

struct FileListView: View {
    @EnvironmentObject var pocketFoldersManager: PocketFoldersManager

    
    var body: some View {
        if pocketFoldersManager.folders.isEmpty {
            Text("Go to Settings (CMD + ,) and add folders to your pockets")
                .foregroundStyle(.secondary)
                .padding(.bottom)
        } else {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(pocketFoldersManager.folders, id: \.path) { folder in
                        let path = folder.path
                        
                        if let files = try? FileManager.default.contentsOfDirectory(atPath: path).filter({ name in
                            !name.starts(with: /[\.\$]/) // Filter out system files
                        }) {
                            if files.isEmpty {
                                HStack {
                                    Image(systemName: "nosign")
                                    Text("\(folder.name) is empty")
                                }
                                .foregroundStyle(.secondary)
                            } else {
                                ForEach(files, id: \.self) { file in
                                    FilePreviewView(filePath: "\(path)/\(file)")
                                }
                            }
                        } else {
                            VStack {
                                Image(systemName: "exclamationmark.triangle")
                                Text("Error reading files from \(folder.name)")
                                    .fixedSize()
                                    .bold()
                                Text("\(folder.path)")
                                    .fixedSize()
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    FileListView()
        .environmentObject(PocketFoldersManager())
}
