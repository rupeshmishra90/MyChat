//
//  ChatMessageModel.swift
//  MyChat
//
//  Created by Rupesh Mishra on 07/05/25.
//

import Foundation
import FirebaseFirestore

struct ChatMessageModel: Codable, Identifiable, Equatable{
    var documentId: String?
    let text: String
    let uid: String
    let dateCreated: Date
    let displayName: String
    var id: String{
        documentId ?? UUID().uuidString
    }
}

extension ChatMessageModel{
    func toDictionary() -> [String: Any]{
        return ["text": text, "displayName": displayName, "dateCreated": dateCreated, "uid": uid]
    }
    
    static func fromSnapshot(snapshot: QueryDocumentSnapshot)-> ChatMessageModel?{
        let dic = snapshot.data()
        guard let text = dic["text"] as? String,
              let displayName = dic["displayName"] as? String,
              let dateCreated = (dic["dateCreated"] as? Timestamp)?.dateValue(),
              let uid = dic["uid"] as? String
        else{
            return nil
        }
        var model = ChatMessageModel(documentId: snapshot.documentID, text: text, uid: uid, dateCreated: dateCreated, displayName: displayName)
        model.documentId = snapshot.documentID
        return model
    }
}
