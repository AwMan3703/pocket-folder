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
            Text("Pockets")
                .bold()
        }
        .font(.title3)
        .padding(.vertical)

        // File list
        FileListView()
    }
}

#Preview {
    ContentView()
        .environmentObject(PocketFoldersManager())
}
