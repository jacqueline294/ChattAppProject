//
//  ChatModel.swift
//  ChattAppProject
//
//  Created by jacqueline Ngigi on 2024-10-21.
//

import Foundation
import Firebase

class ChatViewModel: ObservableObject {
    @Published var messages = [Message]()
    @Published var newMessage = ""
    private let db = Firestore.firestore()
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
        loadMessages()
    }
    
    func send() {
        guard !newMessage.isEmpty else { return }
        
        let message = Message(text: newMessage, senderId: userId)
        db.collection("chats").document(userId).collection("messages").addDocument(data: [
            "text": message.text,
            "senderId": message.senderId
        ])
        
        newMessage = ""
    }
    
    func loadMessages() {
        db.collection("chats").document(userId).collection("messages").order(by: "timestamp", descending: true).addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error loading messages: \(error.localizedDescription)")
                return
            }
            
            querySnapshot?.documents.forEach { document in
                let data = document.data()
                let messageText = data["text"] as? String ?? ""
                let senderId = data["senderId"] as? String ?? ""
                
                DispatchQueue.main.async {
                    self.messages.append(Message(text: messageText, senderId: senderId))
                }
            }
        }
    }
}

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let senderId: String
}
