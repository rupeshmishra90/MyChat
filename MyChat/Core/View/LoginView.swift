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
    @EnvironmentObject private var appState: AppState
    private var isFormValid: Bool {
        !email.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace
    }
    private func login() async
    {
        do{
            let _ = try await Auth.auth().signIn(withEmail: email, password: password)
            appState.routes.append(.home)
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
                    appState.routes.append(.signup)
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
        .environmentObject(AppState())
}
