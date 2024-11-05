//
//  Classes.swift
//  pocketFolder
//
//  Created on 31/10/24.
//  
//
    

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


class PocketFolder: Identifiable, Encodable, Decodable {
    public let name: String
    public let path: String
    
    init(pathURL: URL) {
        self.path = pathURL.path
        self.name = pathURL.lastPathComponent
    }
    
    // Coding keys for encoding and decoding
    private enum CodingKeys: String, CodingKey {
        case path
        case name
    }
    
    // Decodable initializer
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.path = try container.decode(String.self, forKey: .path)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    // Encodable method (already implemented correctly)
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.path, forKey: .path)
        try container.encode(self.name, forKey: .name)
    }
}
