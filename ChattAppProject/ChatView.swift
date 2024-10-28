//
//  ChatView.swift
//  ChattAppProject
//
//  Created by jacqueline Ngigi on 2024-10-28.
//

import SwiftUI
import Firebase

struct ChatView: View {
    @StateObject var chatManager = ChatManager()
    var chat: Chat
    
    @State private var messageText = ""
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(chatManager.messages) { message in
                    MessageRowView(message: message, isCurrentUser: message.senderId == Auth.auth().currentUser?.uid)
                }
            }
            .padding(.vertical)
            
            HStack {
                TextField("Message...", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button {
                    chatManager.sendMessage(messageText, to: chat)
                    messageText = ""
                } label: {
                    Text("Send")
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
            }
            .padding()
        }
        .navigationTitle(chat.username)
        .onAppear {
            chatManager.observeMessages(chatId: chat.id)
        }
    }
}

struct MessageRowView: View {
    let message: Message
    let isCurrentUser: Bool
    
    var body: some View {
        HStack {
            if isCurrentUser { Spacer() }
            Text(message.text)
                .padding()
                .background(isCurrentUser ? Color.blue : Color.gray.opacity(0.2))
                .foregroundColor(isCurrentUser ? .white : .black)
                .cornerRadius(10)
            if !isCurrentUser { Spacer() }
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}


#Preview {
    ChatView()
}
