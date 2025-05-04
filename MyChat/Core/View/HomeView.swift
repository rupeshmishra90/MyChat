//
//  HomeView.swift
//  MyChat
//
//  Created by Rupesh Mishra on 24/04/25.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        TabView{
            GroupListContainerView()
                .tabItem {
                    Label("Chats", systemImage: "message.fill")
                }
            Text("Settings")
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

#Preview {
    HomeView()
}
