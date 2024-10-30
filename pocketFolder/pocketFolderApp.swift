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
        WindowGroup(Text("Pocket Folder")) { // Pocket window
            ContentView()
        }
        .defaultPosition(.top)
        .windowResizability(WindowResizability.contentSize)
        .windowStyle(HiddenTitleBarWindowStyle())
        
        Settings { // Settings window
            SettingsView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        setupWindowBackground()
        hideTitleBar()
    }

    func setupWindowBackground() {
        guard let window = NSApplication.shared.windows.first else { assertionFailure(); return }
        let visualEffectView = NSVisualEffectView(frame: window.contentView?.bounds ?? .zero)
        visualEffectView.autoresizingMask = [.width, .height]
        visualEffectView.material = .popover
        visualEffectView.state = .active
        visualEffectView.blendingMode = .behindWindow
        window.contentView?.superview?.addSubview(visualEffectView, positioned: .below, relativeTo: window.contentView)
    }

    func hideTitleBar() {
        guard let window = NSApplication.shared.windows.first else { assertionFailure(); return }
        window.standardWindowButton(.closeButton)?.isHidden = true
        window.standardWindowButton(.miniaturizeButton)?.isHidden = true
        window.standardWindowButton(.zoomButton)?.isHidden = true
    }
}
