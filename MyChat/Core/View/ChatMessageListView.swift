//
//  ChatMessageListView.swift
//  MyChat
//
//  Created by Rupesh Mishra on 12/05/25.
//

import SwiftUI

struct ChatMessageListView: View {
    var chatMessages: [ChatMessageModel]
    var body: some View {
        List(chatMessages){ chatMessage in
            Text(chatMessage.text)
        }
    }
}

#Preview {
    ChatMessageListView(chatMessages: [])
}
