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
    func updateDisplayName(for user: User, displayName: String) async throws
    {
        let request = user.createProfileChangeRequest()
        request.displayName = displayName
        try? await request.commitChanges()
    }
    
    
    func populateGroups() async
    {
        let db = Firestore.firestore()
        self.groups = []
        let snapshot = try! await db.collection("Groups").getDocuments()
        for document in snapshot.documents {
            
        }
    }
    
    
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
