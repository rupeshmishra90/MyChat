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
    @StateObject private var model = UserDisplayNameModel()
    @StateObject private var appState = AppState()
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appState.routes){
                ZStack{
                    if Auth.auth().currentUser != nil{
                        HomeView()
                    } else{
                        LoginView()
                    }
                }.navigationDestination(for: Route.self) { route in
                    switch route {
                    case .login:
                        LoginView()
                    case .signup:
                        SignupView()
                    case .home:
                        HomeView()
                    }
                }
            }
            .environmentObject(model)
            .environmentObject(appState)
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
