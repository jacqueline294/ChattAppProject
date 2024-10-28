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
    
    init() {
        FirebaseApp.configure()
    }
   
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
