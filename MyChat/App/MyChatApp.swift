//
//  MyChatApp.swift
//  MyChat
//
//  Created by Rupesh Mishra on 21/04/25.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

@main
struct MyChatApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                if Auth.auth().currentUser != nil{
                    HomeView()
                } else{
                    LoginView()
                }
            }
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
