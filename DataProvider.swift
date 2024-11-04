//
//  DataProvider.swift
//  pocketFolder
//
//  Created on 31/10/24.
//  
//
    
import SwiftUI
import Foundation


class DataProvider: ObservableObject {
    @Published var paths: [PocketFolder] = DataProvider.loadPaths() {
        // Automatically save whenever paths is updated
        didSet { savePaths() }
    }
    
    
    public func savePaths() {
        // Encode and save to UserDefaults
        if let encoded = try? JSONEncoder().encode(self.paths) {
            UserDefaults.standard.set(encoded, forKey: "pocketedPaths")
        }
        print("Saved folders")
    }
    
    private static func loadPaths() -> [PocketFolder] {
        // Decode from UserDefaults if data exists
        if let savedPaths = UserDefaults.standard.data(forKey: "pocketedPaths"),
           let decoded = try? JSONDecoder().decode([PocketFolder].self, from: savedPaths) {
            print("Loaded folders")
            return decoded
        } else { return [] }
    }
}

