//
//  FilePreviewView.swift
//  pocketFolder
//
//  Created on 05/11/24.
//  
//

import SwiftUI
import QuickLookThumbnailing


struct FilePreviewView: View {
    let filePath: String
    @State private var thumbnail: NSImage = NSImage(size: NSSize(width: 70, height: 70))
    @State private var fileSizeString: String = "Unknown size"
    
    var body: some View {
        VStack {
            Image(nsImage: thumbnail)
                .resizable()
                .scaledToFit() // Keeps aspect ratio
                .frame(width: 70, height: 70) // Fixed height, width adjusts automatically
            VStack {
                Text((filePath as NSString).lastPathComponent)
                Text(fileSizeString)
                    .foregroundStyle(.secondary)
            }
            .frame(width: 100)
            .lineLimit(1)
            .truncationMode(.middle)
        }
        .onAppear {
            getThumbnailImage()
            getFileSizeString()
        }
        // Add drag capability
        .onDrag {
            // Provide the file URL as a drag item
            let fileURL = URL(fileURLWithPath: filePath)
            return NSItemProvider(object: fileURL as NSURL)
        }
        // Double-click gesture to open the file
        .onTapGesture(count: 2) {
            openFile()
        }
    }
    
    private func openFile() {
        let fileURL = URL(fileURLWithPath: filePath)
        // Use NSWorkspace to open the file
        NSWorkspace.shared.open(fileURL)
    }
    
    private func getThumbnailImage() {
        let request = QLThumbnailGenerator.Request(
            fileAt: URL(fileURLWithPath: filePath),
            size: thumbnail.size,
            scale: 2.0, // Higher quality
            representationTypes: .all
        )
        let generator = QLThumbnailGenerator.shared
        
        generator.generateRepresentations(for: request) { (thumbnail, type, error) in
            DispatchQueue.main.async {
                if let cgImage = thumbnail?.cgImage {
                    self.thumbnail = NSImage(cgImage: cgImage, size: NSSize(width: cgImage.width, height: cgImage.height))
                } else {
                    //print("Thumbnail failed to generate: \(error!.localizedDescription)")
                }
            }
        }
    }
    
    private func getFileSizeString() {
        do {
            let attributes = try FileManager.default.attributesOfItem(atPath: filePath) as NSDictionary
            let fileSize: UInt64 = attributes.fileSize()
            fileSizeString = ByteCountFormatter.string(fromByteCount: Int64(fileSize), countStyle: .decimal)
        } catch {
            print("Unable to get file size for \(filePath): \(error.localizedDescription)")
        }
    }
}

#Preview {
    FilePreviewView(filePath: "../assets/icon.png")
}
