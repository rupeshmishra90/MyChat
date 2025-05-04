//
//  GroupModel.swift
//  MyChat
//
//  Created by Rupesh Mishra on 30/04/25.
//

import Foundation
import FirebaseFirestore

struct GroupModel: Codable, Identifiable{
    var documentId: String? = nil
    let subject: String
    
    var id: String{
        documentId ?? UUID().uuidString
    }
}

extension GroupModel{
    func toDictionary() -> [String: Any]{
        return ["subject": subject]
    }
    static func fromSnapshot(snapshot: QueryDocumentSnapshot)->GroupModel?{
        let dic = snapshot.data()
        guard let subject = dic["subject"] as? String else{
            return nil
        }
        return GroupModel(documentId: snapshot.documentID, subject: subject)
    }
}
