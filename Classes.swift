//
//  Classes.swift
//  pocketFolder
//
//  Created on 31/10/24.
//  
//
    

import Foundation
import SwiftUI
import Combine


class PocketFoldersManager: ObservableObject {
    @Published var folders: [PocketFolder] = PocketFoldersManager.loadFolders() {
        didSet {
            saveFolders()
            startWatchingNewFolders()
        }
    }
    
    private var folderWatchers: [URL: DispatchSourceFileSystemObject] = [:]

    init() {
        startWatchingFolders()
    }

    private func startWatchingFolders() {
        for folder in folders {
            watch(folder: folder)
        }
    }
    
    private func startWatchingNewFolders() {
        // Watch any folder that is not currently being watched
        for folder in folders {
            let url = URL(fileURLWithPath: folder.path)
            if folderWatchers[url] == nil {
                watch(folder: folder)
            }
        }
    }

    private func watch(folder: PocketFolder) {
        let url = URL(fileURLWithPath: folder.path)
        let folderDescriptor = open(folder.path, O_EVTONLY)

        let watcher = DispatchSource.makeFileSystemObjectSource(fileDescriptor: folderDescriptor,
                                                                eventMask: [.write, .delete, .extend, .attrib, .link],
                                                                queue: DispatchQueue.main)
        
        watcher.setEventHandler { [weak self] in
            self?.objectWillChange.send()
            // Update the view when an event occurs in the folder
            DispatchQueue.main.async { [weak self] in
                self?.reloadFolderContents(for: folder)
            }
        }
        
        watcher.setCancelHandler {
            close(folderDescriptor)
        }

        watcher.resume()
        folderWatchers[url] = watcher
    }

    private func reloadFolderContents(for folder: PocketFolder) {
        // Trigger view update to refresh file list
        objectWillChange.send()
    }

    public func saveFolders() {
        if let encoded = try? JSONEncoder().encode(self.folders) {
            UserDefaults.standard.set(encoded, forKey: "pocketedPaths")
        }
    }

    private static func loadFolders() -> [PocketFolder] {
        if let savedPaths = UserDefaults.standard.data(forKey: "pocketedPaths"),
           let decoded = try? JSONDecoder().decode([PocketFolder].self, from: savedPaths) {
            return decoded
        } else { return [] }
    }

    deinit {
        for watcher in folderWatchers.values {
            watcher.cancel()
        }
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
