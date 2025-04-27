//
//  UserDisplayNameModel.swift
//  MyChat
//
//  Created by Rupesh Mishra on 22/04/25.
//

import Foundation
import FirebaseAuth

@MainActor
class UserDisplayNameModel: ObservableObject{
    func updateDisplayName(for user: User, displayName: String) async throws
    {
        let request = user.createProfileChangeRequest()
        request.displayName = displayName
        try? await request.commitChanges()
    }
}
