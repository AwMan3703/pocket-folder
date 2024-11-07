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
        MenuBarExtra("Pocket", systemImage: "briefcase") {
            ContentView()
                .environmentObject(pocketFoldersManager)
                .ignoresSafeArea()
                .frame(width: 700)
                .fixedSize()
        }
        .menuBarExtraStyle(.window)

        Settings {
            SettingsView()
                .environmentObject(pocketFoldersManager)
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        guard let pocketWindow = NSApplication.shared.windows.first else { assertionFailure(); return }
        setupWindowBackground(window: pocketWindow)
        hideTitleBar(window: pocketWindow)
        centerWindow(window: pocketWindow, topMargin: 30.0)
    }

    func setupWindowBackground(window: NSWindow) {
        let visualEffectView = NSVisualEffectView(frame: window.contentView?.bounds ?? .zero)
        visualEffectView.material = .popover
        visualEffectView.state = .active
        visualEffectView.blendingMode = .behindWindow
        window.contentView?.superview?.addSubview(visualEffectView, positioned: .below, relativeTo: window.contentView)
    }

    func hideTitleBar(window: NSWindow) {
        window.titleVisibility = .hidden
        window.titlebarAppearsTransparent = true
        window.standardWindowButton(.closeButton)?.isHidden = true
        window.standardWindowButton(.miniaturizeButton)?.isHidden = true
        window.standardWindowButton(.zoomButton)?.isHidden = true
    }
    
    func centerWindow(window: NSWindow, topMargin: CGFloat) {
        // Get the main screen size
        guard let screen = window.screen else { return }
        
        let screenHeight = screen.frame.height
        let screenWidth = screen.frame.width
        let windowWidth = window.frame.width
        
        // Position the window at the top-center of the screen
        let xPosition = (screenWidth - windowWidth) / 2
        let yPosition = screenHeight - (window.frame.height + topMargin)
        window.setFrameOrigin(NSPoint(x: xPosition, y: yPosition))
    }
}
