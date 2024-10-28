//
//  ChatManager.swift
//  ChattAppProject
//
//  Created by jacqueline Ngigi on 2024-10-28.
//

import Foundation
import Firebase



class ChatManager: ObservableObject {
    @Published var recentChats = [Chat]
    @Published var messages = [Message]()
    
    func fetchRecentChats() {
        let db = Firestore.firestore()
        db.collection("chats").getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            self.recentChats = documents.map { doc in
                let data = doc.data()
                return Chat(id: doc.documentID, username: data["username"] as? String ?? "", lastMessage: data["lastMessage"] as? String ?? "")
            }
        }
    }
    
    func observeMessages(chatId: String) {
        let db = Firestore.firestore()
        db.collection("chats").document(chatId).collection("messages").order(by: "timestamp").addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            self.messages = documents.map { doc in
                let data = doc.data()
                return Message(id: doc.documentID, text: data["text"] as? String ?? "", senderId: data["senderId"] as? String ?? "")
            }
        }
    }
    
    func sendMessage(_ text: String, to chat: Chat) {
        let db = Firestore.firestore()
        let messageData: [String: Any] = [
            "text": text,
            "senderId": Auth.auth().currentUser?.uid ?? "",
            "timestamp": FieldValue.serverTimestamp()
        ]
        db.collection("chats").document(chat.id).collection("messages").addDocument(data: messageData)
    }
}
