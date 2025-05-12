//
//  UserDisplayNameModel.swift
//  MyChat
//
//  Created by Rupesh Mishra on 22/04/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


@MainActor
class UserDisplayNameModel: ObservableObject{
    @Published var groups: [GroupModel] = []
    @Published var chatMessages: [ChatMessageModel] = []
    var fireStoreLister: ListenerRegistration?
    func updateDisplayName(for user: User, displayName: String) async throws
    {
        let request = user.createProfileChangeRequest()
        request.displayName = displayName
        try? await request.commitChanges()
    }
    func ditachFirebaseListener(){
        fireStoreLister?.remove()
    }
    func listenForChatMessages(in group: GroupModel){
        let db = Firestore.firestore()
        chatMessages.removeAll()
        guard let documentId = group.documentId else { return }
        self.fireStoreLister = db.collection("Groups")
            .document(documentId)
            .collection("messages")
            .order(by: "dateCreated", descending: false)
            .addSnapshotListener{[weak self] snapshot, error in
                guard let snapshot = snapshot else{
                    print("Error fetching snapshots: \(error?.localizedDescription ?? "")")
                    return
                }
                snapshot.documentChanges.forEach{ change in
                    if change.type == .added {
                        let chatMessage = ChatMessageModel.fromSnapshot(snapshot: change.document)
                        if let chatMessage{
                            let exists = self?.chatMessages.contains { msg in
                                msg.documentId == chatMessage.documentId
                            }
                            if !(exists ?? false){
                                self?.chatMessages.append(chatMessage)
                            }
                        }
                    }
                }
            }
    }
    
    func populateGroups() async throws
    {
        let db = Firestore.firestore()
        let snapshot = try await db.collection("Groups").getDocuments()
        groups = snapshot.documents.compactMap { snap in
            GroupModel.fromSnapshot(snapshot: snap)
        }
    }
    
    
    func saveChatMessageToGroup(chatMessage: ChatMessageModel, group: GroupModel) async throws {
        let db = Firestore.firestore()
        guard let groupDocumentID = group.documentId else { return }
        try await db.collection("Groups")
            .document(groupDocumentID)
            .collection("messages")
            .addDocument(data: chatMessage.toDictionary())
    }
    
    
/*    func saveChatMessageToGroup(msg: String, group: GroupModel, completion: @escaping (Error?)-> Void)
    {
        let db = Firestore.firestore()
        guard let groupDocumentID = group.documentId else { return }
        db.collection("Groups")
            .document(groupDocumentID)
            .collection("messages")
            .addDocument(data: ["chatText": msg]){ error in
                completion(error)
            }
    }
    */
    func saveGroup(group: GroupModel, completion: @escaping (Error?)-> Void)
    {
        let db = Firestore.firestore()
        var docRef: DocumentReference? = nil
        
        docRef = db.collection("Groups")
            .addDocument(data: group.toDictionary()){ error in
                if error != nil{
                    completion(error)
                }else{
                    if let docRef{
                        var newGroup = group
                        newGroup.documentId = docRef.documentID
                        self.groups.append(newGroup)
                        completion(nil)
                    }else{
                        completion(nil)
                    }
                }
            }
    }
}
