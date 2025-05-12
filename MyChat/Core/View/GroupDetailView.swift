//
//  GroupDetailView.swift
//  MyChat
//
//  Created by Rupesh Mishra on 07/05/25.
//

import SwiftUI
import FirebaseAuth

struct GroupDetailView: View {
    let group: GroupModel
    @EnvironmentObject private var model: UserDisplayNameModel
    @State private var chatText: String = ""
    
    
    private func sendMessage() async throws {
        guard let currentUser = Auth.auth().currentUser else{ return}
        let chatMessage = ChatMessageModel(text: chatText, uid: currentUser.uid, dateCreated: Date(), displayName: currentUser.displayName ?? "Guest")
        try await model.saveChatMessageToGroup(chatMessage: chatMessage, group: group)
    }
    
    
    var body: some View {
        VStack{
            ChatMessageListView(chatMessages: model.chatMessages)
            Spacer()
            HStack(spacing: 10){
                TextField("Write here", text: $chatText)
                Button("Send")
                {
                    Task{
                        do{
                            try await sendMessage()
                            chatText = ""
                        }catch{
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }.padding()
            .onDisappear{
                model.ditachFirebaseListener()
            }
            .onAppear{
                model.listenForChatMessages(in: group)
            }
    }
}

#Preview {
    GroupDetailView(group: GroupModel(subject: "Family"))
        .environmentObject(UserDisplayNameModel())
}
