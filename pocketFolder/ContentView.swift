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
            Image(systemName: "folder.fill")
                .foregroundStyle(.tint)
            Text("My files")
        }
        .font(.title)
        .bold()
        
        HStack { // File list
        }
        
        HStack { // Footer
        }
    }
}

#Preview {
    ContentView()
}
