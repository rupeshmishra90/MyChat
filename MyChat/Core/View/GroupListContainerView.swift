//
//  GroupListContainerView.swift
//  MyChat
//
//  Created by Rupesh Mishra on 30/04/25.
//

import SwiftUI

struct GroupListContainerView: View {
    @State private var isPresented: Bool = false
    @EnvironmentObject private var model: UserDisplayNameModel
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button("New Group"){
                    isPresented = true
                }
            }
            GroupListView(groups: model.groups)
            Spacer()
        }
        .task {
            do{
                try await model.populateGroups()
            }catch{
                print(error.localizedDescription)
            }
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
        .environmentObject(UserDisplayNameModel())
}
