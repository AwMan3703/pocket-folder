//
//  SettingsView.swift
//  pocketFolder
//
//  Created by @AwMan3703 (GitHub) on 30/10/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var dataProvider: DataProvider
    
    
    var body: some View {
        FolderManagerView()
            .padding()
    }
}

#Preview {
    SettingsView()
        .environmentObject(DataProvider())
}
