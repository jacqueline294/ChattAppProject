//
//  ChatListView.swift
//  ChattAppProject
//
//  Created by jacqueline Ngigi on 2024-10-28.
//

import SwiftUI
import Firebase


struct ChatListView: View {
    @State private var isProfileViewPresented = false
    @ObservedObject var chatManager = ChatManager()
    
    var body: some View {
        NavigationView {
            List(chatManager.recentChats) { chat in
                NavigationLink(destination: ChatView(chat: chat)) {
                    ChatRowView(chat: chat)
                }
            }
            .navigationTitle("Chats")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isProfileViewPresented = true
                    } label: {
                        Image(systemName: "person.circle")
                            .font(.system(size: 24))
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // Action to start a new chat
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .font(.system(size: 24))
                    }
                }
            }
            .sheet(isPresented: $isProfileViewPresented) {
                ProfileView()
            }
            .onAppear {
                chatManager.fetchRecentChats()
            }
        }
    }
}

struct ChatRowView: View {
    var chat: Chat
    
    var body: some View {
        HStack {
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .padding(.trailing, 8)
            VStack(alignment: .leading) {
                Text(chat.username)
                    .font(.headline)
                Text(chat.lastMessage)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 8)
    }
}


#Preview {
    ChatListView()
}
