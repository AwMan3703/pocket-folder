//
//  ContentView.swift
//  pocketFolder
//
//  Created by @AwMan3703 (GitHub) on 29/10/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        HStack { // Header
            Image(systemName: "square.grid.3x1.folder.fill.badge.plus")
                .foregroundStyle(.tint)
            Text("Pocket-Folder")
        }
        .font(.title)
        .bold()
        
        ViewThatFits { // File list
            FileListView()
        }
        
        HStack { // Footer
            HStack{ // credit
                Text("Made with")
                Image(systemName: "heart.fill")
                    .foregroundStyle(.tint)
                    .imageScale(.large)
                Text("by")
                Link(destination: URL(string: "https://github.com/AwMan3703")!, label: { Text("Aw Man") })
            }
        }
    }
}

#Preview {
    ContentView()
}
