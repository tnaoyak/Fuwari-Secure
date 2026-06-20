//
//  AppDelegate.swift
//  Fuwari
//
//  Created by Kengo Yokoyama on 2016/11/29.
//  Copyright © 2016年 AppKnop. All rights reserved.
//

import Cocoa
import Carbon
import Magnet
import LaunchAtLogin

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    private let defaults = UserDefaults.standard
    private var screenshotManager: ScreenshotManager?
    
    override init() {
        // Initialize UserDefaults value
        defaults.register(defaults: [Constants.UserDefaults.movingOpacity: 0.7])
        defaults.register(defaults: [Constants.UserDefaults.suppressAlertForLoginItem: false])
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Show Login Item
        if !LaunchAtLogin.isEnabled && !defaults.bool(forKey: Constants.UserDefaults.suppressAlertForLoginItem) {
            promptToAddLoginItems()
        }
        
        HotKeyManager.shared.configure()
        MenuManager.shared.configure()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        HotKeyCenter.shared.unregisterAll()
    }
    
    @objc func openPreferences() {
        NSApp.activate(ignoringOtherApps: true)
        PreferencesWindowController.shared.showWindow(self)
    }
    
    @objc func openAbout() {
        NSApp.activate(ignoringOtherApps: true)
        AboutWindowController.shared.showWindow(self)
    }
    
    @objc func capture() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.Notification.capture), object: nil)
    }
    
    @objc func quit() {
        NSApp.terminate(nil)
    }

    private func promptToAddLoginItems() {
        let alert = NSAlert()
        alert.messageText = LocalizedString.LaunchFuwari.value
        alert.informativeText = LocalizedString.LaunchSettingInfo.value
        alert.addButton(withTitle: LocalizedString.LaunchOnStartup.value)
        alert.addButton(withTitle: LocalizedString.DontLaunch.value)
        alert.showsSuppressionButton = true
        NSApp.activate(ignoringOtherApps: true)
        
        //  Launch on system startup
        if alert.runModal() == NSApplication.ModalResponse.alertFirstButtonReturn {
            LaunchAtLogin.isEnabled = true
        }
        // Do not show this message again
        if alert.suppressionButton?.state == .on {
            defaults.set(true, forKey: Constants.UserDefaults.suppressAlertForLoginItem)
        }
    }
}
