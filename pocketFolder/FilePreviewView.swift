//
//  FilePreviewView.swift
//  pocketFolder
//
//  Created on 05/11/24.
//  
//

import SwiftUI

struct FilePreviewView: View {
    let filePath: String
    
    var body: some View {
        Text(filePath)
    }
}

#Preview {
    FilePreviewView(filePath: "../assets/icon.png")
}
