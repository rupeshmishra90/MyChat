//
//  SignupView.swift
//  MyChat
//
//  Created by Rupesh Mishra on 22/04/25.
//

import SwiftUI
import FirebaseAuth

struct SignupView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var displayName: String = ""
    @State private var errorMessage: String = ""
    @EnvironmentObject private var model: UserDisplayNameModel
    
    private var isFormValid: Bool {
        !email.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace && !displayName.isEmptyOrWhiteSpace
    }
    
    private func signup() async
    {
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            try await model.updateDisplayName(for: result.user, displayName: displayName)
        }catch{
            errorMessage = error.localizedDescription
        }
    }
    var body: some View {
        Form{
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
                .textInputAutocapitalization(.never)
            TextField("Display name", text: $displayName)
            
            HStack(spacing: 10){
                Spacer()
                Button("SignUp"){
                    Task{
                        await signup()
                    }
                }.disabled(!isFormValid)
                    .buttonStyle(.borderless)
                
                Button("Login")
                {
                    //Redirect to login here
                }.buttonStyle(.borderless)
                Spacer()
            }
            
            Text(errorMessage)
                .foregroundStyle(.red)
        }
    }
}

#Preview {
    SignupView().environmentObject(UserDisplayNameModel())
}
