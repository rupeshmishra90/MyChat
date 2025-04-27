//
//  LoginView.swift
//  MyChat
//
//  Created by Rupesh Mishra on 23/04/25.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    private var isFormValid: Bool {
        !email.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace
    }
    private func login() async
    {
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
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
            
            HStack(spacing: 10){
                Spacer()
                Button("Login"){
                    Task{
                        await login()
                    }
                }.disabled(!isFormValid)
                    .buttonStyle(.borderless)
                
                Button("Register")
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
    LoginView()
}
