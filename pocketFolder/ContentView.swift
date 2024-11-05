//
//  ContentView.swift
//  pocketFolder
//
//  Created by @AwMan3703 (GitHub) on 29/10/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var pocketFoldersManager: PocketFoldersManager
    
    
    var body: some View {
        HStack { // Header
            Image(systemName: "folder.fill")
                .foregroundStyle(.linearGradient(Gradient(colors: Theme.gradientColors), startPoint: .topLeading, endPoint: .bottomTrailing))
            Text("Pocket-Folder")
        }
        .padding()
        .font(.title2)
        .bold()
        
        HStack { // File list
            FileListView()
        }
        
        HStack { // Footer
            HStack{ // credit
                Text("by")
                Link(destination: URL(string: "https://github.com/AwMan3703")!, label: { Text("Aw Man") })
                    .foregroundStyle(.linearGradient(Gradient(colors: Theme.gradientColors), startPoint: .topLeading, endPoint: .bottomTrailing))
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environmentObject(PocketFoldersManager())
}
