//
//  ContentView.swift
//  pocketFolder
//
//  Created by @AwMan3703 (GitHub) on 29/10/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var pocketFoldersManager: PocketFoldersManager
    @Environment(\.openSettings) private var openSettings
    
    
    var body: some View {
        // Header
        HStack {
            HStack {
                Image(systemName: "folder.fill")
                    .foregroundStyle(.linearGradient(Gradient(colors: Theme.gradientColors), startPoint: .topLeading, endPoint: .bottomTrailing))
                Text("Pockets")
                    .bold()
            }
            .font(.title3)
            
            Spacer()
            
            Button(action: {
                NSApp.activate()
                openSettings()
            }, label: {
                HStack {
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .foregroundStyle(.primary)
            })
            // Native settings button
            //SettingsLink()
        }
        .padding()

        // File list
        FileListView()
    }
}

#Preview {
    ContentView()
        .environmentObject(PocketFoldersManager())
}
