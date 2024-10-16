//
//  ChatView.swift
//  ChattAppProject
//
//  Created by jacqueline Ngigi on 2024-10-16.
//

import SwiftUI


struct ChatView: View {
    
    @State var newMessage = ""
    
    var body: some View {
        VStack {
                    List(viewModel.messages) { message in
                        Text(message.text)
                            .padding(.vertical, 8)
                    }
                    
                    HStack {
                        TextField("Type a message...", text: $newMessage)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button(action: {
                            viewModel.send()
                            newMessage = ""
                        }) {
                            Image(systemName: "paperplane")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                }
                .navigationTitle("Chat")
            }
        }



#Preview {
    ChatView()
}
