//
//  ChattAppProjectApp.swift
//  ChattAppProject
//
//  Created by jacqueline Ngigi on 2024-10-15.
//

import SwiftUI
import Firebase

@main
struct ChattAppProjectApp: App {
    
    // Add the AppDelegate to the SwiftUI lifecycle
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
