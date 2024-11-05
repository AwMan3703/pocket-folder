//
//  SettingsView.swift
//  pocketFolder
//
//  Created by @AwMan3703 (GitHub) on 30/10/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var pocketFoldersManager: PocketFoldersManager
    
    
    var body: some View {
        VStack {
            FolderManagerView()
        }
        .padding()
        
        HStack{ // credit
            Text("Made with")
            Image(systemName: "heart.fill")
                .foregroundStyle(.linearGradient(Gradient(colors: Theme.gradientColors), startPoint: .topLeading, endPoint: .bottomTrailing))
                .imageScale(.large)
            Text("by")
            Link(destination: URL(string: "https://github.com/AwMan3703")!, label: { Text("Aw Man") })
                .foregroundStyle(.linearGradient(Gradient(colors: Theme.gradientColors), startPoint: .topLeading, endPoint: .bottomTrailing))
        }
        .padding()
    }
}

#Preview {
    SettingsView()
        .environmentObject(PocketFoldersManager())
}
