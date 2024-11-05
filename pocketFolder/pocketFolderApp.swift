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
    @StateObject private var pocketFoldersManager = PocketFoldersManager()
    
    
    var body: some Scene {
        WindowGroup(Text("Pocket")) { // Pocket window
            ContentView()
                .environmentObject(pocketFoldersManager)
                .ignoresSafeArea()
                .frame(minHeight: 100)
        }
        .defaultPosition(.top)
        .windowResizability(WindowResizability.contentSize)
        .windowStyle(HiddenTitleBarWindowStyle())
        
        Settings { // Settings window
            SettingsView()
                .environmentObject(pocketFoldersManager)
                .frame(minWidth: 500)
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        guard let pocketWindow = NSApplication.shared.windows.first else { assertionFailure(); return }
        setupWindowBackground(window: pocketWindow)
        hideTitleBar(window: pocketWindow)
        centerWindow(window: pocketWindow)
    }

    func setupWindowBackground(window: NSWindow) {
        let visualEffectView = NSVisualEffectView(frame: window.contentView?.bounds ?? .zero)
        visualEffectView.autoresizingMask = [.width, .height]
        visualEffectView.material = .popover
        visualEffectView.state = .active
        visualEffectView.blendingMode = .behindWindow
        window.contentView?.superview?.addSubview(visualEffectView, positioned: .below, relativeTo: window.contentView)
    }

    func hideTitleBar(window: NSWindow) {
        window.standardWindowButton(.closeButton)?.isHidden = true
        window.standardWindowButton(.miniaturizeButton)?.isHidden = true
        window.standardWindowButton(.zoomButton)?.isHidden = true
    }
    
    func centerWindow(window: NSWindow) {
        // Get the main screen size
        let screen = window.screen
        if screen == nil { return }
        
        guard let screenHeight = screen?.frame.height else { return }
        guard let screenWidth = screen?.frame.width else { return }
        let windowWidth = window.frame.width
        
        // Position the window at the top-center of the screen
        let xPosition = (screenWidth - windowWidth) / 2
        let yPosition = screenHeight - window.frame.height
        window.setFrameOrigin(NSPoint(x: xPosition, y: yPosition))
    }
}
