//
//  AppState.swift
//  MyChat
//
//  Created by Rupesh Mishra on 24/04/25.
//

import Foundation

enum Route: Hashable{
    case home
    case login
    case signup
}

class AppState: ObservableObject{
    @Published var routes: [Route] = []
}
