//
//  FileListView.swift
//  pocketFolder
//
//  Created by @AwMan3703 (GitHub) on 30/10/24.
//

import SwiftUI

struct FileListView: View {
    @EnvironmentObject var dataProvider: DataProvider
    
    
    var body: some View {
        Text("Files here!")
    }
}

#Preview {
    FileListView()
        .environmentObject(DataProvider())
}
