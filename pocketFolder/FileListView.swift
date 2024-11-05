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
        } else {
            ScrollView(.horizontal) {
                HStack(alignment: .center) {
                    ForEach(pocketFoldersManager.folders, id: \.path) { folder in
                        if let files = try? FileManager.default.contentsOfDirectory(atPath: folder.path) {
                            ForEach(files, id: \.self) { file in
                                Text(file)
                            }
                        } else {
                            VStack {
                                Image(systemName: "exclamationmark.triangle")
                                Text("\(folder.name)")
                                    .fixedSize()
                                    .bold()
                                Text("Error loading files")
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
