//
//  Classes.swift
//  pocketFolder
//
//  Created on 31/10/24.
//  
//
    

import Foundation


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
