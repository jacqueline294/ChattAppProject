//
//  ChatUser.swift
//  ChattAppProject
//
//  Created by jacqueline Ngigi on 2024-11-03.
//

import Foundation

struct ChatUser:Identifiable {
    var id: String { uid }
    let uid, email, profileImageUrl: String
    
    init(data: [String: Any]){
        self.uid = data["uid"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.profileImageUrl = data["profileImageUrl"] as? String ?? ""
    }
}
