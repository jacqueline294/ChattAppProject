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
                    
                    
                    HStack {
                        TextField("Type a message...", text: $newMessage)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button(action: {
                            
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
