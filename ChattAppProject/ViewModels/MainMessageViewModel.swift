//
//  MainMessageViewModel.swift
//  ChattAppProject
//
//  Created by jacqueline Ngigi on 2024-10-29.
//

import Foundation




class MainMessagesViewModel: ObservableObject {
    
    @Published var errorMessage = ""
    @Published var chatUser: ChatUser?
    
    init() {
        fetchCurrentUser()
    }
    
    private func fetchCurrentUser() {
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            self.errorMessage = "Could not find firebase uid"
            return
        }
        
        
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                self.errorMessage = "Failed to fetch current user: \(error)"
                print("Failed to fetch current user:", error)
                return
            }
            

            
            guard let data = snapshot?.data() else {
                self.errorMessage = "No data found"
                return
                
            }
            self.chatUser = .init(data: data)
        }
    }
      
    @Published var isUserCurrentLoggedOut = false
    
    func handleSignOut() {
        isUserCurrentLoggedOut.toggle()
        try? FirebaseManager.shared.auth.signOut()
        
    }
}
