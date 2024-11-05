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
        HStack {
            ForEach(pocketFoldersManager.folders, id: \.path) { folder in
                if let files = try? FileManager.default.contentsOfDirectory(atPath: folder.path) {
                    
                    ForEach(files, id: \.self) { file in
                        Text(file)
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    FileListView()
        .environmentObject(PocketFoldersManager())
}
