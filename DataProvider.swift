//
//  DataProvider.swift
//  pocketFolder
//
//  Created on 31/10/24.
//  
//
    
import SwiftUI
import Foundation


class PocketFoldersManager: ObservableObject {
    @Published var folders: [PocketFolder] = PocketFoldersManager.loadFolders() {
        // Automatically save whenever paths is updated
        didSet { saveFolders() }
    }
    
    
    public func saveFolders() {
        // Encode and save to UserDefaults
        if let encoded = try? JSONEncoder().encode(self.folders) {
            UserDefaults.standard.set(encoded, forKey: "pocketedPaths")
        }
        print("Saved folders")
    }
    
    private static func loadFolders() -> [PocketFolder] {
        // Decode from UserDefaults if data exists
        if let savedPaths = UserDefaults.standard.data(forKey: "pocketedPaths"),
           let decoded = try? JSONDecoder().decode([PocketFolder].self, from: savedPaths) {
            print("Loaded folders")
            return decoded
        } else { return [] }
    }
}

