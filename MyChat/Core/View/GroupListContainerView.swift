//
//  GroupListContainerView.swift
//  MyChat
//
//  Created by Rupesh Mishra on 30/04/25.
//

import SwiftUI

struct GroupListContainerView: View {
    @State private var isPresented: Bool = false
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button("New Group"){
                    isPresented = true
                }
            }
            Spacer()
        }
        .padding()
        .sheet(isPresented: $isPresented)
        {
            AddNewGroupView()
        }
    }
}

#Preview {
    GroupListContainerView()
}
