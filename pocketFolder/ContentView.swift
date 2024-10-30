//
//  ContentView.swift
//  pocketFolder
//
//  Created by @AwMan3703 (GitHub) on 29/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            Label(
                title: { Text("My files") },
                icon: { Image(systemName: "folder.fill") }
            )
            .font(.title)
            .bold()
            .padding()
        }
        HStack {
        }
        HStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
    }
}

#Preview {
    ContentView()
        .position(CGPoint(x: 0.0, y: 0.0))
}
