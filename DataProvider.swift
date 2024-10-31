//
//  DataProvider.swift
//  pocketFolder
//
//  Created on 31/10/24.
//  
//
    
import SwiftUI
import Foundation


struct DataProvider {
    public static func savePaths(paths: [PocketFolder]) {
        // Encode and save to UserDefaults
        if let encoded = try? JSONEncoder().encode(paths) {
            UserDefaults.standard.set(encoded, forKey: "pocketedPaths")
        }
    }
    
    public static func loadPaths() -> [PocketFolder] {
        // Decode from UserDefaults if data exists
        if let savedPaths = UserDefaults.standard.data(forKey: "pocketedPaths"),
           let decoded = try? JSONDecoder().decode([PocketFolder].self, from: savedPaths) {
            return decoded
        } else { return [] }
    }
}
