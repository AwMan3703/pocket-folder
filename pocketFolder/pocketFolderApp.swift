//
//  pocketFolderApp.swift
//  pocketFolder
//
//  Created by @AwMan3703 (GitHub) on 29/10/24.
//

import SwiftUI

@main
struct pocketFolderApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        hideTitleBar()
    }

    func hideTitleBar() {
        guard let window = NSApplication.shared.windows.first else { assertionFailure(); return }
        window.standardWindowButton(.closeButton)?.isHidden = true
        window.standardWindowButton(.miniaturizeButton)?.isHidden = true
        window.standardWindowButton(.zoomButton)?.isHidden = true
    }
}
